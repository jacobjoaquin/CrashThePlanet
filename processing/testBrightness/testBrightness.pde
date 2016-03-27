Vst vst;
Serial serial;

void settings() {
  size(500, 500, P2D);
  pixelDensity(displayDensity());
}

void setup() {
  serial = createSerial();
  vst = new Vst(this, serial);
  vst.displayTransit = true;
  frameRate(50);
}

void draw() {
  background(0);

  brightnessLines();

  // Display();
  vst.display();
}

void brightnessLines() {
  int nLines = 64;
  pushMatrix();
  translate(0, height / 2.0);
  for (int i = 0; i < nLines; i++) {
    float n = i / (float) nLines;
    float x = n * width;
    stroke(n * 256);
    line(x, -50, x, 50);
  }
  popMatrix();
}

//void keyPressed() {
// serial.stop();
// exit();
//}