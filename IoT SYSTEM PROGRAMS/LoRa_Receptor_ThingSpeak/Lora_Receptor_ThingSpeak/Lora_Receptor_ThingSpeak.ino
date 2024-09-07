#include <SPI.h>
#include <LoRa.h>     
#include <WiFi.h>
#include <U8g2lib.h>  
#include "ThingSpeak.h"
#include "WiFi.h"

const char* ssid = "INFINITUMB494_2.4";
const char* password = "Zfq7FHZENk";

unsigned long ChannelID = 1881573;
const char* WriteAPIKey = "ROXKWUZPNG9SXIYL";

WiFiClient Client;

const int PUBLISH_FREQUENCY = 10000; 
unsigned long timer;

#define OFF 0  
#define ON 1

// SPI LoRa Radio
#define LORA_SCK 5       
#define LORA_MISO 19     
#define LORA_MOSI 27    
#define LORA_CS 18     
#define LORA_RST 23   
#define LORA_IRQ 26  

// I2C OLED Display works with SSD1306 driver
#define OLED_SDA 21
#define OLED_SCL 22
#define OLED_RST 23

U8G2_SSD1306_128X64_NONAME_F_SW_I2C Display(U8G2_R0, /* clock=*/ OLED_SCL, /* data=*/ OLED_SDA, /* reset=*/ OLED_RST); 

const int blueLED = LED_BUILTIN; 

String rssi = "";
String packet = "";

//Variables del proceso de secado 
String temp1, hume1;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("LoRa Receiver");

  WiFi.begin(ssid,password);
  while (WiFi.status()!=WL_CONNECTED){
    delay(500);
    Serial.print(".");
  }
  Serial.print("WiFi conectado!");

  ThingSpeak.begin(Client);

  Display.begin();
  Display.enableUTF8Print(); 
  Display.setFont(u8g2_font_ncenB10_tr);

  SPI.begin(LORA_SCK, LORA_MISO, LORA_MOSI, LORA_CS); 
  LoRa.setPins(LORA_CS, LORA_RST, LORA_IRQ);         
  pinMode(blueLED, OUTPUT); 
 
  if (!LoRa.begin(915E6)) {
    Serial.println("Starting LoRa failed!");
    while (1);
  }
  
  LoRa.setSpreadingFactor(12);  

  timer = millis();

  delay(1000);
  
}

void loop() {
  
//  if (abs(millis() - timer) > PUBLISH_FREQUENCY){ // triggers the routine every 5 seconds
  

   int pos1, pos2, pos3, pos4, pos5;
     
  int packetSize = LoRa.parsePacket();
  if (packetSize) {
    Serial.print("Received packet '");
    String LoRaData = LoRa.readString();
    Serial.println(LoRaData);
    digitalWrite(blueLED, ON);  // Turn blue LED on
    
    while (LoRa.available()) {
      Serial.println((char)LoRa.read());
    }

    pos1 = LoRaData.indexOf('+');
    pos2 = LoRaData.indexOf('#');
    pos3 = LoRaData.indexOf('$');
//    pos4 = LoRaData.indexOf('&');
//    pos5 = LoRaData.indexOf('*');


    temp1 = LoRaData.substring(pos1+1, pos2);
    hume1 = LoRaData.substring(pos2+1, pos3);
//    temp2 = LoRaData.substring(pos3+1, pos4);
//    hume2 = LoRaData.substring(pos4+1, pos5);

    float temperature1 = temp1.toFloat();
    float humidity1 = hume1.toFloat();
//    float temperature2 = temp2.toFloat();
//    float humidity2 = hume2.toFloat();

    Serial.print("T: ");
    Serial.print(temperature1);
    Serial.print("RH: ");
    Serial.print(humidity1);
//    Serial.print("T: ");
//    Serial.print(temperature2);
//    Serial.print("RH: ");
//    Serial.print(humidity2);
    
    rssi = LoRa.packetRssi();

    Display.clearBuffer();  
    Display.setCursor(0,12); Display.print("LoRa Receiver");
    Display.setCursor(0,26); Display.print("Received LoRaData:");
    Display.setCursor(0,42); Display.print("    '" + LoRaData + "'");
    Display.setCursor(0,58); Display.print("RSSI " + rssi);
    Display.sendBuffer();

    digitalWrite(blueLED, OFF); 
    
    Serial.println(packet + "' with RSSI " + rssi); 

    if (temperature1 != 0 && humidity1 !=0){
//          if (temperature2 != 0 && humidity2 !=0){
                 ThingSpeak.setField(1,temperature1);
                 ThingSpeak.setField(2,humidity1);
//                 ThingSpeak.setField(3,temperature2);
//                 ThingSpeak.setField(4,humidity2);
                 ThingSpeak.writeFields(ChannelID,WriteAPIKey);
                 Serial.println("Datos enviados a ThingSpeak!");
//          }
    }

//    timer = millis();
  
  }
//}
}
