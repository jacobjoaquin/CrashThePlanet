/*
 * (c) 2016 Trammell Hudson, Holly Hudson, Adelle Lin, Duncan Malashock and Jacob Joaquin
 */

import java.io.File;

Vst vst;
Demos demos;
int startingAnimationIndex = 0;
VstDataRecorder vstDataRecorder;
int defaultDurationInSeconds = 5;

// raindrops
Scene theScene;

void settings() {
  size(500, 500);  // Vectrex dimensions
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  // vst.displayTransit = true;
  // vstRecorder = new VstRecorder(vst, "MEH.DAT");
  // vstDataRecorder = new VstDataRecorder(vst, "MEH.DAT");
  // vst.displayTheBuffer = false;

  File f = new File(sketchPath("") + "NODISPLAY");
  if(f.exists() && !f.isDirectory()) { 
    vst.displayTheBuffer = false;
  }

  blendMode(ADD);

  demos = new Demos();
  demos.setAnimationIndex(startingAnimationIndex);

  demos.add(new StarScene());


  // Intro
  Demo vstText = new VstDataPlayback(vst, "VSTLINES.DAT");
  vstText.setDurationInSeconds(5);
  demos.add(vstText);
  Demo ctpText = new VstDataPlayback(vst, "CTP.DAT");
  ctpText.setDurationInSeconds(5);
  demos.add(ctpText);


  // Me
  demos.add(new CircleThing());
  // demos.add(new PolarSine());
  demos.add(new SpiralDemo(5, 12, 300, 0));
  demos.add(new VstDataPlayback(vst, "GRID.DAT"));

  // Trammell
  demos.add(new Demo3D());
  demos.add(new SwarmDemo());
  demos.add(new QixDemo());
  
  // Holly
  demos.add(new FlowerDemo());

  // Adelle
  Demo catcher = new VstDataPlayback(vst, "CATCHER.DAT");
  catcher.setFrameRate(25);
  demos.add(catcher);

  // Duncan
  demos.add(new Scene());


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