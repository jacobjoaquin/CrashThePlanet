class FlowerDemo extends Demo {
  FlowerList bouquet = new FlowerList();

  FlowerDemo() {
    setFrameRate(25);
  }

  void update() {
    bouquet.update();
  }

  void display() {
    bouquet.display();
  }
}

class FlowerList extends DisplayableList<Flower> {
  void update() {
    if (floor(random(40)) == 0) {
      add(new Flower(
        random(50, width - 50), 
        random(50, height - 50), 
        (int)ceil(random(5.1, 8.9)), 
        random(0.5, 1.5), 
        random(-0.2, 0.2)));
    }

    for (Flower blossom : this) {
      if (blossom.age > 140) {
        blossom.complete();
      }
    }
    
    super.update();
  }
}

class Flower extends Demo {
  float xpos;
  float ypos;
  int num_petals;
  float scale_size = 1;
  float rotation_rate; // 0.0 - 0.1 looks nice
  float rotation_state = 0;
  int age = 0;

  Flower(float tempxpos, float tempypos, int tempnum_petals, float tempscale_size, float temprotation_rate) {
    xpos = tempxpos;
    ypos = tempypos;
    num_petals = tempnum_petals;
    scale_size = tempscale_size;
    rotation_rate = temprotation_rate;
  }

  void display() {
    pushMatrix();
    pushStyle();
    stroke(100);

    // move to first flower petal position
    translate(xpos, ypos);
    rotate(rotation_state += rotation_rate);
    scale(scale_size);

    // draw the flower
    for (int i = 0; i < num_petals; i++) {
      ellipse(0, 15, 20, 80);
      rotate(2*PI/num_petals);
    }

    popStyle();
    popMatrix();
    age += 1;
  }
}