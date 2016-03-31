boolean captureFrames = false;
String filename = "CTP.DAT";
VstDataRecorder vstDataRecorder;
int nFrames = 40;
float phase = 0;
float phaseInc = 1.0 / nFrames;
float maxDepth = -1500;
float tileSize = 125;
float sideLength = 4000;

Vst vst;

void settings() {
  size(500, 500, P3D);
  pixelDensity(displayDensity());
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());
  blendMode(ADD);

  vstDataRecorder = new VstDataRecorder(vst, filename);
  vstDataRecorder.beginRecord();
}


void draw() {
  background(0);

  // Tower and Horizon
  stroke(255);
  vst.line(260, -5000, maxDepth, 255, height, maxDepth);
  vst.line(240, -5000, maxDepth, 245, height, maxDepth);
  vst.line(-sideLength, height, maxDepth, sideLength, height, maxDepth);

  // Grid
  stroke(127);
  for (int i = (int) -sideLength; i <= sideLength; i += tileSize) { 
    vst.line(i, height, 0, i, height, maxDepth);
  }
  for (int i = 0; i >= maxDepth; i -= tileSize) {
    float offset = i + phase * tileSize;
    vst.line(-sideLength, height, offset, sideLength, height, offset);
  }

  // Send to Vst
  vst.display();

  // Update phasor
  phase += phaseInc;  
  phase -= (int) phase;

  // Record
  if (captureFrames) {
    vstDataRecorder.update();
    if (frameCount == nFrames) {
      vstDataRecorder.endRecord();
      exit();
    }
  }

  vst.buffer.clear();
}