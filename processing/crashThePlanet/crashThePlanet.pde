/*
 * (c) 2016 Trammell Hudson, Holly Hudson, Adelle Lin, Duncan Malashock and Jacob Joaquin
 */

Vst vst;
Demos demos;
int startingAnimationIndex = 0;
VstRecorder vstRecorder;

// raindrops
Scene theScene;

void settings() {
  size(500, 500);  // Vectrex dimensions
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.displayTransit = true;
  // vstRecorder = new VstRecorder(vst, "MEH.DAT");
  vst.displayTheBuffer = false;
  blendMode(ADD);

  demos = new Demos();
  demos.setAnimationIndex(startingAnimationIndex);

  // Add animations
  demos.add(new Demo3D());
  demos.add(new SwarmDemo());
  demos.add(new QixDemo());
  demos.add(new SpiralDemo(4, 16, 200, 0));
  // demos.add(new Grid());
  demos.add(new Scene());
  demos.add(new PolarSine());
  demos.add(new Foo());

  // Recording
  // vstRecorder.beginRecord();
}

void draw() {
  background(0);
  demos.update();
  pushMatrix();
  scale(0.5);
  demos.display();
  popMatrix();
  vst.display();

  // Recording
  // vstRecorder.update();
  // if (frameCount == 20) {
  //   vstRecorder.endRecord();
  // }
}