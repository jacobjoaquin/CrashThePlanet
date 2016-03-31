class Star implements canUpdate, canDisplay {
  private PVector position;
  private PVector velocity;
  private int age;
  
  Star(PVector p, PVector v) {
    position = p;
    velocity = v;
    age = 0;
  }
  
  float getPositionX() {
    return position.x;
  }
  
  float getPositionY() {
    return position.y;
  }
  
  boolean finished() {
    return false;
  }

  void update(int timestep) {
    position.x += velocity.x * timestep;
    position.y += velocity.y * timestep;
    age += timestep;
  }

  int draw_intensity() {
    int fade_in_time = 10;
    float max_brightness = Math.min(velocity.mag(), 2.5) / 2.5;
    float fade_amount = (float)Math.min(age, fade_in_time) / fade_in_time;
    float intensity = max_brightness * fade_amount;
    return (int)(intensity * 255);
  }
  
  void display() {
    stroke(draw_intensity());
    line(position.x, position.y, position.x - velocity.x * 2, position.y - velocity.y * 2); 
  }
}