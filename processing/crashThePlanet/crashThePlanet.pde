/*
 * (c) 2016 Trammell Hudson, Adelle Lin and Jacob Joaquin
 */

Vst vst;
Demos demos;
int startingAnimationIndex = 4;
int animationDuration = 100;

void settings() {
  size(500, 500, P3D);  // Vectrex dimensions
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  //vst.displayTransit = true;
  blendMode(ADD);

  demos = new Demos();
  demos.setAnimationIndex(startingAnimationIndex);
  demos.setAnimationDuration(animationDuration);

  // Add animations
  demos.add(new Demo3D());
  demos.add(new SwarmDemo());
  demos.add(new QixDemo());
  demos.add(new SpiralDemo());
  demos.add(new Grid());
}

void draw() {
  background(0);
  demos.update();
  demos.display();
  vst.display();
}