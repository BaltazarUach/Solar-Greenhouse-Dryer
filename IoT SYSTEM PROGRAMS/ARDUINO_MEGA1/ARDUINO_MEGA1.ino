#include <Wire.h>
#include <SPI.h>
#include <SoftwareSerial.h>
#include <Adafruit_Sensor.h>
#include "Adafruit_BME680.h"

// Address of BME680 sensors
Adafruit_BME680 bme3; // I2C
Adafruit_BME680 bme4; // I2C

// Serial communication is established with pin 5 (RX) and 6 (TX)
SoftwareSerial TTGO(5, 6);      //  RX, TX --- TTGO LoRa 32 0 Bluetooth

// Define a variable of type String (str)
String datos;

//términos para el funcionamiento de la comunicación serial 
const int lonbuffer = 10;
char buffer[lonbuffer];

// Variables
float temp1, temp2,hume1, hume2;

bool mostrar = false;

unsigned long tiempoAnterior;
int periodo = 1000;

void setup() {
  Serial.begin(9600);

  // Serial port initialization for serial communication
  TTGO.begin(9600);  

  while (!Serial);
  Serial.println(F("BME680 test"));
  if (!bme3.begin()) {
    Serial.println("Could not find a valid BME680 sensor 3, check wiring!");
  }
  if (!bme4.begin(0x76)) {
    Serial.println("Could not find a valid BME680 sensor 4, check wiring!");
  }

  // Initialization of the sensors
  bme3.setTemperatureOversampling(BME680_OS_8X);
  bme3.setHumidityOversampling(BME680_OS_2X);
  bme4.setTemperatureOversampling(BME680_OS_8X);
  bme4.setHumidityOversampling(BME680_OS_2X);

  // Variable initialization
  temp1 = 0;  // Temperature
  hume1 = 0;  // Humidity
  temp2 = 0;  // Temperature
  hume2 = 0;  // Humidity
 
  tiempoAnterior = millis();
   
 delay(1000);
 
}

void loop() {

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

  temp1 = bme3.temperature;
  hume1 = bme3.humidity;
  temp2 = bme4.temperature;
  hume2 = bme4.humidity;  
 
    // Serial monitor
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
  Serial.println("%  ");

  // String to send data to the TTGO LoRa32 board
  datos = TTGO.println("!" +String(temp1) +"#" +String(hume1) +"$" +String(temp2) +"%" +String(hume2));
  TTGO.print(datos);
  }
}
