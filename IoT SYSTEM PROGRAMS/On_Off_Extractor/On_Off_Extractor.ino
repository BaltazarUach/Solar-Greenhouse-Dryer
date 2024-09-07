#include <Wire.h>
#include <Adafruit_ADS1015.h>
#include <SPI.h>
#include <SD.h> 
#include <RTClib.h>   // incluye libreria para el manejo del modulo RTC
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,16,2);  // set the LCD address to 0x27 for a 16 chars and 2 line display

#define SSpin 10  // SD card SS o CS pin
File archivo;     // File object of type File (SD)

RTC_DS3231 rtc;     // crea objeto del tipo RTC_DS3231

Adafruit_ADS1115 ads(0x48);

const float FACTOR = 25; // Depende del tipo de sensor que se utiliza
const float multiplier = 0.0625F; // variar para acer el valor lo mas aproximado al real

int extractor; // if a = 0 off and a = 1 on

unsigned long tiempoAnterior;
int periodo = 5000;

String a = "Encendido";

void setup() {
  Serial.begin(9600);

  // Seteo de la ganancia ver ejemplo diferencial de la libreria ADS
  ads.setGain(GAIN_TWO);        // ±2.048V  1 bit = 0.0625mV
  ads.begin();

  // initialize the lcd 
  lcd.init();                      
  lcd.backlight();

  // SD card initialization 
  Serial.println("Initializing card ...");  
  if (!SD.begin(SSpin)) {     
    Serial.println("Initialization failure !");
    return;
  }
  Serial.println("Successful initialization"); 

  // Para ajustar la fecha y hora, debemos utilizar el siguiente formato:
  // segundos, minutos, horas, dia de la semana, numero de día, mes y año
  //  myRTC.setDS1302Time(30, 14, 20, 7, 13, 11, 2022); // SS, MM, HH, DW, DD, MM, YYYY

 if (! rtc.begin()) {       // si falla la inicializacion del modulo
 Serial.println("Modulo RTC no encontrado !");  // muestra mensaje de error
 while (1);         // bucle infinito que detiene ejecucion del programa
 }

  tiempoAnterior = millis();

}

void loop() {
  // Esta función actualiza las variables para obtener resultados actuales
//  myRTC.updateTime();
 DateTime fecha = rtc.now();      // funcion que devuelve fecha y horario en formato


  if ( (millis() - tiempoAnterior)>=periodo){
    tiempoAnterior = millis(); 

  float CorrienteRMS = getCorriente();
  float Potencia = 110.0 * CorrienteRMS;
    
  // Strings for current date and time
String fecha_actual = "" +String(fecha.day()) +"/" +String(fecha.month())+"/" +String(fecha.year());
 String hora_actual = "" +String(fecha.hour()) +":" +String(fecha.minute())+":" +String(fecha.second());
 
  if (CorrienteRMS > 1){
    extractor = 1;
    a = "Encendido"; 
      // Serial monitor

  }
  else {
    extractor = 0; 
     a = "Apagado"; 

  }

  Serial.print("Date: ");
  Serial.print(fecha_actual);  
  Serial.print("  ");
  Serial.print("Time: ");
  Serial.print(hora_actual);  
  Serial.print("  ");
  Serial.print("Corriente: ");
  Serial.print(CorrienteRMS);
  Serial.print("A");
  Serial.print("  ");
  Serial.print("Potencia: ");
  Serial.print(Potencia);
  Serial.print("W");
  Serial.print("  ");  
  Serial.print("Extractor: ");
  Serial.println(extractor);

  lcd.init();  // initialize the lcd 
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("Fecha: ");
  lcd.setCursor(6,0);
  lcd.print(fecha_actual);
  lcd.setCursor(1,1);
  lcd.print("Hora: ");
  lcd.setCursor(6,1);
  lcd.print(hora_actual);

  lcd.init();  // initialize the lcd 
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("C.Corriente: ");
  lcd.setCursor(12,0);
  lcd.print(CorrienteRMS);
  lcd.setCursor(15,0);
  lcd.print("A");
  lcd.setCursor(1,1);
  lcd.print("Potencia: ");
  lcd.setCursor(10,1);
  lcd.print(Potencia);
  lcd.setCursor(14,1);
  lcd.print("W");

  lcd.init();  // initialize the lcd 
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(3,0);
  lcd.print("Extractor: ");
  lcd.setCursor(3,1);
  lcd.print(a);


   // Data backup
  archivo = SD.open("datos.txt", FILE_WRITE);  
    if(archivo){
       archivo.print("Date:");
       archivo.print(",");
       archivo.print(fecha_actual);
       archivo.print(",");
       archivo.print("Time:");
       archivo.print(",");
       archivo.print(hora_actual);
       archivo.print(",");
       archivo.print("Corriente:");
       archivo.print(",");
       archivo.print(CorrienteRMS);
       archivo.print(",");
       archivo.print("Potencia:");
       archivo.print(",");
       archivo.print(Potencia);
       archivo.print(",");
       archivo.print("Extractor:");
       archivo.print(",");
       archivo.println(extractor);
       archivo.close();
    }

 }

}


float getCorriente()
{
 float Volt_diferencial;
 float corriente;
 float sum = 0;
 long tiempo = millis();
 int counter = 0;
 
 while (millis() - tiempo < 1000)
 {
   Volt_diferencial = ads.readADC_Differential_0_1() * multiplier;
   
   //-----------------------------------------------------
   //Volt_diferencial = ads.readADC_Differential_2_3() * multiplier;
   //-----------------------------------------------------
   
   corriente = Volt_diferencial * FACTOR;
   corriente /= 1000.0;
 
   sum += sq(corriente);
   counter = counter + 1;
  }
 
 corriente = sqrt(sum / counter);
 return(corriente);
}
