const int splSensor1 = A0;   // the SPL output is connected to analog pin 0
const int splSensor2 = A1;

void setup() {
 Serial.begin(9600); //38400
}

void loop() {
  Serial.println(analogRead(splSensor1), DEC);
  Serial.println("#");
  Serial.println(analogRead(splSensor2), DEC);
  Serial.println("$");
  delay(200);  // delay to avoid overloading the serial port buffer
}
