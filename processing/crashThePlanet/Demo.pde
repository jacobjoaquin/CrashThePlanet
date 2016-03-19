class Demos extends DisplayableList<Demo> {
  Demo current;
  private int currentIndex = 0;
  int duration = 1000;
  int framesLeft;
  final static int RANDOM = 0;
  final static int SEQUENTIAL = 1;
  private int mode = SEQUENTIAL;

  Demos() {
    super();
    framesLeft = duration;
  }

  void setMode(int mode) {
    this.mode = mode;
  }

  void update() {
    if (current == null) {
      current = (Demo) get(currentIndex);
      current.init();
    }

    if (framesLeft-- == 0) {
      next();
    }

    current.update();
  }

  void display() {
    current.display();
  }

  void next() {
    framesLeft = duration;
    if (mode == SEQUENTIAL) {
      currentIndex += 1;
      currentIndex %= size();
    } else if (size() > 1) {
      // Ensure new demo is different
      int lastDemo = currentIndex;
      while (lastDemo == currentIndex) {
        currentIndex = (int) random(size());
      }
    }
    current = (Demo) get(currentIndex);
    current.init();
  }
  
  void setAnimationIndex(int index) {
    currentIndex = index;
  }
  
  void setAnimationDuration(int duration) {
    this.duration = duration;
    this.framesLeft = duration;
  }
}

class Demo extends DisplayableBase {
  int theFrameRate = 50;

  void init() {
    frameRate(theFrameRate);
  }
}