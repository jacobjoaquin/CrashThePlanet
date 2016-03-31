class Demos extends DisplayableList<Demo> {
  Demo current;
  private int currentIndex = 0;
  int framesLeft;
  final static int RANDOM = 0;
  final static int SEQUENTIAL = 1;
  private int mode = SEQUENTIAL;

  Demos() {
    super();
  }

  void setMode(int mode) {
    this.mode = mode;
  }

  void update() {
    if (current == null) {
      current = (Demo) get(currentIndex);
      current.init();
      framesLeft = current.getDurationInFrames();
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
    framesLeft = current.getDurationInFrames();
  }
  
  void setAnimationIndex(int index) {
    currentIndex = index;
  }
}

abstract class Demo extends DisplayableBase {
  private int theFrameRate = 50;
  private float durationInSeconds = defaultDurationInSeconds;

  void init() {
    frameRate(theFrameRate);
  }

  void setFrameRate(int fr) {
    theFrameRate = fr;
  }

  int getDurationInFrames() {
    return (int) ((float) theFrameRate * durationInSeconds);
  }
}