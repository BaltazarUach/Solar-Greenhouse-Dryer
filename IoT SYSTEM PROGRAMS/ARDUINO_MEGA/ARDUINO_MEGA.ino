#include <Wire.h>
#include <SPI.h>
#include <RTClib.h>
#include <SoftwareSerial.h>
#include <Adafruit_Sensor.h>
#include "Adafruit_BME680.h"
#include <SD.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

#define SSpin 53  // SD card SS o CS pin
File archivo;     // File object of type File (SD)

// Address of BME680 sensors
Adafruit_BME680 bme3; // I2C
Adafruit_BME680 bme4; // I2C

// Serial communication is established with pin 5 (RX) and 6 (TX)
SoftwareSerial TTGO(5, 6);      //  RX, TX --- TTGO LoRa 32 0 Bluetooth

RTC_DS3231 rtc; // Create object of type RTC_DS3231

// Define a variable of type String (str)
String datos;

//términos para el funcionamiento de la comunicación serial 
const int lonbuffer = 10;
char buffer[lonbuffer];

// Variables
float TEMPERATURA, temp1, temp2, temp3, temp4, HUMEDAD, hume1, hume2, hume3, hume4;

bool mostrar = false;

unsigned long tiempoAnterior;
int periodo = 10000;

void setup() {
  Serial.begin(9600);

  // Serial port initialization for serial communication
  TTGO.begin(9600);  

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
  
  while (!Serial);
  Serial.println(F("BME680 test"));
  if (!bme3.begin()) {
    Serial.println("Could not find a valid BME680 sensor 3, check wiring!");
  }
  if (!bme4.begin(0x76)) {
    Serial.println("Could not find a valid BME680 sensor 4, check wiring!");
  }

  // Initialization of the RCT DS3231
 if (! rtc.begin()) {      
 Serial.println("RTC module not found !"); 
 while (1);         
 }

  // Initialization of the sensors
  bme3.setTemperatureOversampling(BME680_OS_8X);
  bme3.setHumidityOversampling(BME680_OS_2X);
  bme4.setTemperatureOversampling(BME680_OS_8X);
  bme4.setHumidityOversampling(BME680_OS_2X);

  // Variable initialization
  TEMPERATURA = 0;
  HUMEDAD = 0;
  temp1 = 0;  // Temperature
  hume1 = 0;  // Humidity
  temp2 = 0;  // Temperature
  hume2 = 0;  // Humidity
  temp3 = 0;  // Temperature
  hume3 = 0;  // Humidity
  temp4 = 0;  // Temperature
  hume4 = 0;  // Humidity 

  tiempoAnterior = millis();
   
 delay(1000);
 
}

void loop() {
DateTime fecha = rtc.now(); 

    if (Serial.available()>0) {

      Serial.readBytesUntil('!', buffer, lonbuffer);
      temp1 = Serial.parseFloat();

      Serial.readBytesUntil('#', buffer, lonbuffer);
      hume1 = Serial.parseFloat();

      Serial.readBytesUntil('$', buffer, lonbuffer);
      temp2 = Serial.parseFloat();
      
      Serial.readBytesUntil('%', buffer, lonbuffer);
      hume2 = Serial.parseFloat();
    }


  if ( (millis() - tiempoAnterior)>=periodo){
    tiempoAnterior = millis(); 
     //******** temperature sensor check *****

  if (! bme3.performReading()) {
    Serial.println("Failed to perform reading bme3 :(");
    return;
  }
  if (! bme4.performReading()) {
    Serial.println("Failed to perform reading bme4 :(");
    return;
  }

  temp3 = bme3.temperature;
  hume3 = bme3.humidity;
  temp4 = bme4.temperature;
  hume4 = bme4.humidity;  

 // Strings for current date and time
  String fecha_actual = "" +String(fecha.day()) +"/" +String(fecha.month())+"/" +String(fecha.year());
  String hora_actual = "" +String(fecha.hour()) +":" +String(fecha.minute())+":" +String(fecha.second());

  TEMPERATURA = (temp1 + temp2 + temp3 + temp4)/4;
HUMEDAD = (hume1 + hume2 + hume3 + hume4)/4;
 
    // Serial monitor
  Serial.print("Date:");
  Serial.print(fecha_actual);  
  Serial.print("  ");
  Serial.print("Time:");
  Serial.print(hora_actual);  
  Serial.print("  ");
  Serial.print("Temperature 1: ");
  Serial.print(temp1);
  Serial.print("*C  ");
  Serial.print("Humidity 1: ");
  Serial.print(hume1);
  Serial.print("%  ");
  Serial.print("  ");
  Serial.print("Temperature 2: ");
  Serial.print(temp2);
  Serial.print("*C  ");
  Serial.print("Humidity 2: ");
  Serial.print(hume2);
  Serial.print("%  ");
  Serial.print("  ");
  Serial.print("Temperature 3: ");
  Serial.print(temp3);
  Serial.print("*C  ");
  Serial.print("Humidity 3: ");
  Serial.print(hume3);
  Serial.print("%  ");
  Serial.print("  ");
  Serial.print("Temperature 4: ");
  Serial.print(temp4);
  Serial.print("*C  ");
  Serial.print("Humidity 4: ");
  Serial.print(hume4);
  Serial.println("%  ");

  // lcd setup
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("Fecha:");
  lcd.setCursor(6,0);
  lcd.print(fecha_actual);
    lcd.setCursor(0,1);
  lcd.print("Hora:");
  lcd.setCursor(5,1);
  lcd.print(hora_actual);

  lcd.init();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("T1: ");
  lcd.setCursor(3,0);
  lcd.print(temp1);
  lcd.print("*C");
  lcd.setCursor(10,0);
  lcd.print("RH1: ");
  lcd.setCursor(14,0);
  lcd.print(hume1);
  lcd.print("%");

  lcd.setCursor(0,1);
  lcd.print("T2: ");
  lcd.setCursor(3,1);
  lcd.print(temp2);
  lcd.print("*C");
  lcd.setCursor(10,1);
  lcd.print("RH2: ");
  lcd.setCursor(14,1);
  lcd.print(hume2);
  lcd.print("%");

  lcd.setCursor(0,2);
  lcd.print("T3: ");
  lcd.setCursor(3,2);
  lcd.print(temp3);
  lcd.print("*C");
  lcd.setCursor(10,2);
  lcd.print("RH3: ");
  lcd.setCursor(14,2);
  lcd.print(hume3);
  lcd.print("%");

  lcd.setCursor(0,3);
  lcd.print("T4: ");
  lcd.setCursor(3,3);
  lcd.print(temp4);
  lcd.print("*C");
  lcd.setCursor(10,3);
  lcd.print("RH4: ");
  lcd.setCursor(14,3);
  lcd.print(hume4);
  lcd.print("%");


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
  archivo.print("Temperature 1:");
  archivo.print(",");
  archivo.print(temp1);
  archivo.print(",");
  archivo.print("Humidity 1: ");
  archivo.print(",");
  archivo.print(hume1);
  archivo.print(",");
  archivo.print("Temperature 2:");
  archivo.print(",");
  archivo.print(temp2);
  archivo.print(",");
  archivo.print("Humidity 2: ");
  archivo.print(",");
  archivo.print(hume2);
  archivo.print(",");
  archivo.print("Temperature 3:");
  archivo.print(",");
  archivo.print(temp3);
  archivo.print(",");
  archivo.print("Humidity 3: ");
  archivo.print(",");
  archivo.print(hume3);
  archivo.print(",");
  archivo.print("Temperature 4:");
  archivo.print(",");
  archivo.print(temp4);
  archivo.print(",");
  archivo.print("Humidity 4: ");
  archivo.print(",");
  archivo.println(hume4);  
  archivo.close();
  }
  

  // String to send data to the TTGO LoRa32 board
  datos = TTGO.println("!" +String(TEMPERATURA) +"#" +String(HUMEDAD));
  TTGO.print(datos);
  }
}
