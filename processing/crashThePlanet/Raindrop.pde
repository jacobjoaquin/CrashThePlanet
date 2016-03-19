class Raindrop implements canUpdate, canDisplay {
  private float position_x;
  private float position_y;
  private float velocity_y;
  
  Raindrop(float x, float y, float vy) {
    position_x = x;
    position_y = y;
    velocity_y = vy;
  }
  
  float getPositionX() {
    return position_x;
  }
  
  float getPositionY() {
    return position_y;
  }

  void update(int timestep) {
    position_y += velocity_y * timestep;
  }
  
  void display() {
    stroke(255);
    line(position_x, position_y, position_x, position_y - (int)velocity_y); 
  }
}