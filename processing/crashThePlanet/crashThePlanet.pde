/*
 * (c) 2016 Trammell Hudson, Adelle Lin and Jacob Joaquin
 */

Vst vst;
Demos demos;

void settings() {
  size(500, 500, P2D);  // Vectrex dimensions
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  //vst.displayTransit = true;
  blendMode(ADD);

  demos = new Demos();
  demos.add(new Demo3D());
  demos.add(new SwarmDemo());
  demos.add(new QixDemo());
  demos.add(new SpiralDemo());
}

void draw() {
  background(0);
  demos.update();
  demos.display();
  vst.display();
}