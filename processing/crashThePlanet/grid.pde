class Grid extends DisplayableBase {
  float maxDepth = -1500;
  float tileSize = 150;
  float sideLength = 4000;
  float phase = 0.0;
  float phaseInc = 1 / 20.0;

  void update() {
    phase += phaseInc;  
    phase -= (int) phase;
  }
  
  void display() {
    // Tower and Horizon
    stroke(255);
    line(255, -5000, maxDepth, 255, height, maxDepth);
    line(245, -5000, maxDepth, 245, height, maxDepth);
    line(-sideLength, height, maxDepth, sideLength, height, maxDepth);

    // Grid
    stroke(127);
    for (int i = (int) -sideLength; i <= sideLength; i += tileSize) { 
      line(i, height, 0, i, height, maxDepth);
    }

    for (int i = 0; i >= maxDepth; i -= tileSize) {
      float offset = i + phase * tileSize;
      line(-sideLength, height, offset, sideLength, height, offset);
    }
  }
}