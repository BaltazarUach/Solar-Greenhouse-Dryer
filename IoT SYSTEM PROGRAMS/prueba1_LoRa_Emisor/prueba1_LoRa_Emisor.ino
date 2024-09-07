/* Example from Sandeep Mistry 
 * With mods from AliExpress/LilyGo docs
 * For TTGo ESP32 LoRa-OLED board
 * http://www.lilygo.cn/down_view.aspx?TypeId=11&Id=78&Fid=t14:11:14
 * Based on SX1276 LoRa Radio
 * http://www.semtech.com/apps/product.php?pn=SX1276
 * RMB 29Nov2017
 */

#include <SPI.h>
#include <LoRa.h>       // https://github.com/sandeepmistry/arduino-LoRa
#include <U8g2lib.h>   // https://github.com/olikraus/U8g2_Arduino
// #include <U8x8lib.h>

#define OFF 0   // For LED
#define ON 1

// SPI LoRa Radio
#define LORA_SCK 5        // GPIO5 - SX1276 SCK
#define LORA_MISO 19     // GPIO19 - SX1276 MISO
#define LORA_MOSI 27    // GPIO27 -  SX1276 MOSI
#define LORA_CS 18     // GPIO18 -   SX1276 CS
#define LORA_RST 23   // GPIO14 -    SX1276 RST
#define LORA_IRQ 26  // GPIO26 -     SX1276 IRQ (interrupt request)

// I2C OLED Display works with SSD1306 driver
#define OLED_SDA 21
#define OLED_SCL 22
#define OLED_RST 23

/* Pick One. Hardware I2C does NOT work! This article helped: https://robotzero.one/heltec-wifi-kit-32/ 
* TTGo boards similar to Heltec boards, LED_BUILTIN = 2 instead of pin 25
* Some OLED displays don't handle ACK correctly so SW I2C works better. Thank you Olikraus!
* TTGo OLED has pin 16 reset unlike other OLED displays
*/

// UNCOMMENT one of the constructor lines below
//U8X8_SSD1306_128X64_NONAME_SW_I2C Display(/* clock=*/ OLED_SCL, /* data=*/ OLED_SDA, /* reset=*/ OLED_RST); // Unbuffered, basic graphics, software I2C
//U8G2_SSD1306_128X64_NONAME_1_SW_I2C Display(U8G2_R0, /* clock=*/ OLED_SCL, /* data=*/ OLED_SDA, /* reset=*/ OLED_RST); // Page buffer, SW I2C
U8G2_SSD1306_128X64_NONAME_F_SW_I2C Display(U8G2_R0, /* clock=*/ OLED_SCL, /* data=*/ OLED_SDA, /* reset=*/ OLED_RST); // Full framebuffer, SW I2C

const int blueLED = LED_BUILTIN; 
int counter = 0;


//términos para el funcionamiento de la comunicación serial 
const int lonbuffer = 10;
char buffer[lonbuffer];

//variables de medición  
float temp1, hume1, temp2, hume2, temp3, hume3, temp4, hume4;
                                                                                       
bool mostrar = false;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("LoRa Sender");

  Display.begin();
  Display.enableUTF8Print();    // enable UTF8 support for the Arduino print() function
  Display.setFont(u8g2_font_ncenB10_tr);
  
  // Very important for SPI pin configuration!
  SPI.begin(LORA_SCK, LORA_MISO, LORA_MOSI, LORA_CS); 
  
  // Very important for LoRa Radio pin configuration! 
  LoRa.setPins(LORA_CS, LORA_RST, LORA_IRQ);         

  pinMode(blueLED, OUTPUT); // For LED feedback

  if (!LoRa.begin(915E6)) {
    Serial.println("Starting LoRa failed!");
    while (1);
  }
  
  // The larger the spreading factor the greater the range but slower data rate
  // Send and receive radios need to be set the same
  LoRa.setSpreadingFactor(12); // ranges from 6-12, default 7 see API docs

  // Change the transmit power of the radio
  // Default is LoRa.setTxPower(17, PA_OUTPUT_PA_BOOST_PIN);
  // Most modules have the PA output pin connected to PA_BOOST, gain 2-17
  // TTGO and some modules are connected to RFO_HF, gain 0-14
  // If your receiver RSSI is very weak and little affected by a better antenna, change this!
  LoRa.setTxPower(20, PA_OUTPUT_PA_BOOST_PIN);
  
}

void loop() {
  
    if (Serial.available()>0) {
     
      Serial.readBytesUntil('!', buffer, lonbuffer);
      temp1 = Serial.parseFloat();

      Serial.readBytesUntil('#', buffer, lonbuffer);
      hume1 = Serial.parseFloat();
      
      mostrar = true;
  }

  if(mostrar && temp1!=0 ){
   
    
  String DatosLoRa ="+" +String(temp1) +"#" +String(hume1) +"$";  //SE MODIFICO SE AGREGO UN ULTIMO CARACTER

  Serial.println(DatosLoRa);
  
  digitalWrite(blueLED, ON);  // Turn blue LED on
  // send packet
  LoRa.beginPacket();
  LoRa.print("DatosLoRa! ");
  LoRa.print(DatosLoRa);
  LoRa.endPacket();
  digitalWrite(blueLED, OFF); // Turn blue LED off 
  // Display Info
  Display.clearBuffer();  
  Display.setCursor(0,12); Display.print("Paquete recidibo");
  Display.setCursor(0,30); Display.print("Los datos son:");
  Display.setCursor(0,48); Display.print(" # " + (String)DatosLoRa);
  Display.sendBuffer();
     
    mostrar = false;
  }
 delay(1000);
}
