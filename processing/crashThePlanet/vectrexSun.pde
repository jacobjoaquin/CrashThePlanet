class SunPoint extends DisplayableBase {
  PVector center = new PVector(width / 2.0, height / 2.0);
  PVector end;
  int nFrames = 80;
  int framesLeft = nFrames;
  color c = 0;
  float angle;
  float addAngle;
  float theLength = 0;
  float lengthAdd;
  
  SunPoint() {
    angle = random(TAU);
    addAngle += TAU * random(-0.002, 0.002);
    lengthAdd = random(1, 4);
  }
  
  void update() {
    framesLeft--;
    theLength += lengthAdd;
    angle += addAngle;
    end = PVector.fromAngle(angle).mult(theLength).add(center);
    if (framesLeft <= 0) {
      complete();
    }
    c = color(sin(framesLeft / (float) nFrames * HALF_PI) * 255);
  }
  
  void display() {
    stroke(c);
    line(center, end);
  }
}

class VectrexSun extends DisplayableList<SunPoint> {
  void update() {
    add(new SunPoint());
    super.update();
  }
}

class SunDemo extends Demo {
  VectrexSun vectrexSun = new VectrexSun();

  void init() {
    super.init();
    vectrexSun.clear();
  }
  
  void update() {
    vectrexSun.update();
  }

  void display() {
    vectrexSun.display();
  }
}