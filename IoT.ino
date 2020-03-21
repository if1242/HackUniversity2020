//#include "Arduino.h"
#include "EspMQTTClient.h"
#include "BLEDevice.h"
#include "BLEUtils.h"
#include "BLEScan.h"
#include "BLEAdvertisedDevice.h"

#define PUB_DELAY (10 * 1000) /* 5 seconds */

int scanTime = 5; //In seconds
BLEScan* pBLEScan;

class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks {
    void onResult(BLEAdvertisedDevice advertisedDevice) {
      Serial.printf("Advertised Device: %s \n", advertisedDevice.toString().c_str());
    }
};

EspMQTTClient client(
  "name_wifi",
  "password_wifi",

  "sandbox.rightech.io",
  "id_sensor"
);

void onConnectionEstablished() {
  Serial.println("connected");
}

void setup() {
  BLEDevice::init("");
  pBLEScan = BLEDevice::getScan(); //create new scan
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
  pBLEScan->setActiveScan(true); //active scan uses more power, but get results faster
  pBLEScan->setInterval(100);
  pBLEScan->setWindow(99);  // less or equal setInterval value
}

long last = 0;
void publishData() {
  long now = millis();
  if (client.isConnected() && (now - last > PUB_DELAY)) {

    // put your main code here, to run repeatedly:
    BLEScanResults foundDevices = pBLEScan->start(scanTime, false);
    Serial.print("Devices found: ");
    String str_macs = foundDevices.getCount()
    Serial.println(str_macs);
    Serial.println("Scan done!");
    pBLEScan->clearResults();   // delete results fromBLEScan buffer to release memory

    client.publish("list/macs", String(str_macs));

    last = now;
  }
}

void loop() {
  client.loop();
  publishData();
}
