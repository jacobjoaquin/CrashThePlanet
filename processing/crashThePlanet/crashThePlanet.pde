/*
 * (c) 2016 Trammell Hudson, Holly Hudson, Adelle Lin, Duncan Malashock and Jacob Joaquin
 */

Vst vst;
Demos demos;
int startingAnimationIndex = 0;
VstRecorder vstRecorder;
VstDataRecorder vstDataRecorder;

// raindrops
Scene theScene;

void settings() {
  size(500, 500, P2D);  // Vectrex dimensions
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  vst.displayTransit = true;
  // vstRecorder = new VstRecorder(vst, "MEH.DAT");
  vstDataRecorder = new VstDataRecorder(vst, "MEH.DAT");
  // vst.displayTheBuffer = false;
  blendMode(ADD);

  demos = new Demos();
  demos.setAnimationIndex(startingAnimationIndex);

  // Add animations
  Demo catcher = new VstDataPlayback(vst, "CATCHER.DAT");
  catcher.setFrameRate(25);
  demos.add(catcher);
  demos.add(new Demo3D());
  // demos.add(new SwarmDemo());
  // demos.add(new QixDemo());
  // demos.add(new SpiralDemo(4, 16, 200, 0));
  // // demos.add(new Grid());
  // demos.add(new Scene());
  // demos.add(new PolarSine());
  // demos.add(new Foo());

  // Recording
  // vstDataRecorder.beginRecord();
}

void draw() {
  background(0);
  demos.update();
  demos.display();
  vst.display();

  // Recording
  // vstDataRecorder.update();
  // if (frameCount == 50) {
  //   vstDataRecorder.endRecord();
  //   exit();
  // }

  // TODO: Clear removed from inside of class Vst. This should be handled better
  vst.buffer.clear();
}