boolean captureFrames = true;
Vst vst;
int nFrames = 40;
float phase = 0.0;
float phaseInc = 1 / float(nFrames);
PFont theFont;
VstDataRecorder vstDataRecorder;
PGraphics textLayer;
String filename = "CTP.DAT";
PImage img;

ArrayList<Circle> circles;

void layerCopy(PGraphics source, PGraphics destination) {
  destination.copy(source, 0, 0, width, height, 0, 0, width, height);
}

void settings() {
  size(500, 500, P2D);
}

void setup() {
  frameRate(50);
  vst = new Vst(this, createSerial());

  vstDataRecorder = new VstDataRecorder(vst, filename);
  vstDataRecorder.beginRecord();

  img = loadImage("./data/ctp.png");

  circles = new ArrayList<Circle>();
  int nCircles = 200;
    
  for (int i = 0; i < nCircles; i++) {
    float n = i / (float) nCircles;    
    PVector position = new PVector(random(-100, width + 100), random(height));
    float radius = random(10, 30);
    float distance = random(10, 20);
    float offset = n * TAU * 8;
    Circle circle = new Circle(position, radius, distance, offset);
    circles.add(circle);
  }
}

void draw() {
  background(0);

  // Create Text
  //textFont(theFont);
  //textAlign(CENTER, CENTER);
  //text("V.ST", width / 2.0 - 20, height / 2.0 - 5);
  image(img, 0, 0, width, height, 0, 0, img.width, img.height);

  stroke(64);
  //rayCast(random(width), random(height), random(width), random(height));

  float amt = 0.25;
  float y = (frameCount % nFrames) * amt;
  while (y < height) {
   rayCast(0, y, width, y);
   y += nFrames * amt;
  }

  for (Circle circle : circles) {
    circle.update();
  }
  stroke(255);
  connectCircles();



  phase += phaseInc;
  phase -= (int) phase;

  background(0);
  vst.display();

  if (captureFrames) {
    vstDataRecorder.update();
    if (frameCount == 80) {
      vstDataRecorder.endRecord();
      exit();
    }
  }

  vst.buffer.clear();
}

void connectCircles() {
  pushStyle();
  for (Circle c0 : circles) {
    for (Circle c1 : circles) {
      if (!c0.equals(c1)) {
        if (PVector.dist(c0.orbitPosition, c1.orbitPosition) < c0.radius + c1.radius) {
          //line(c0.orbitPosition.x, c0.orbitPosition.y, c1.orbitPosition.x, c1.orbitPosition.y);
          rayCast(c0.orbitPosition.x, c0.orbitPosition.y, c1.orbitPosition.x, c1.orbitPosition.y);
        }
      }
    }
  }
  popStyle();
}

void rayCast(float x0, float y0, float x1, float y1) {
  int threshold = 128;
  boolean inMask = brightness(get((int) x0, (int) y0)) > threshold ? true : false;
  float x2 = x0;
  float y2 = y0;
  float distance = dist(x0, y0, x1, y1);

  for (int i = 1; i < distance; i++) {
    float n = i / distance;
    float x3 = lerp(x0, x1, n);
    float y3 = lerp(y0, y1, n);

    boolean thisMask = brightness(get((int) x3, (int) y3)) > threshold ? true : false;

    if (inMask != thisMask) {
      inMask = thisMask;
      if (!inMask) {
        line(new PVector(x2, y2), new PVector(x3, y3));
      }
      x2 = x3;
      y2 = y3;
    }
  }
}