class Ripple implements canUpdate, canDisplay {
  private int max_age;
  private int age;
  private boolean finished;
  private float position_x;
  private float position_y;
  private int max_brightness;
  private int max_width;
  private float aspect_ratio;
  private int smoothness;
  
  Ripple(float my_x, float my_y, int my_max_age, int my_max_brightness,
      int my_max_width, float my_aspect_ratio, int my_smoothness) {
    position_x = my_x;
    position_y = my_y;
    max_age = my_max_age;
    max_brightness = my_max_brightness;
    max_width = my_max_width;
    aspect_ratio = my_aspect_ratio;
    smoothness = my_smoothness;
    age = 1;
    finished = false;
  }
  
  boolean finished() {
    return finished;
  }
  
  float percent_completed() {
    return ((float)Math.min(age, max_age) / max_age);
  }
  
  void update(int timestep) {
    age += timestep;
    if (age >= max_age) {
      finished = true;
    }
  }
  
  void display() {
    float width_to_draw = ((float)age / max_age) * max_width;
    int brightness = (int)((1.0 - percent_completed()) * max_brightness);
    stroke(brightness);
    ellipse(position_x, position_y, width_to_draw, width_to_draw * aspect_ratio,
      smoothness);
  }
}