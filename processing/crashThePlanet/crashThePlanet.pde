/*
 * (c) 2016 Trammell Hudson, Adelle Lin and Jacob Joaquin
 */

Vst vst;
Demos demos;
int startingAnimationIndex = 5;

// raindrops
Scene theScene;

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

  // Add animations
  demos.add(new Demo3D());
  demos.add(new SwarmDemo());
  demos.add(new QixDemo());
  demos.add(new SpiralDemo(4, 16, 200, 0));
  demos.add(new Grid());
  demos.add(new Scene());
}

void draw() {
  background(0);
  demos.update();
  demos.display();
  vst.display();
}