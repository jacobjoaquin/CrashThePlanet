class Circle {
  PVector position;
  float radius;
  float distance;
  float offset;
  PVector orbitPosition;
  
  Circle(PVector position, float radius, float distance, float offset) {
    this.position = position;
    this.radius = radius;
    this.distance = distance;
    this.offset = offset;
  }
  
  void update() {
    orbitPosition = PVector.fromAngle((offset + phase) * TAU);
    orbitPosition.mult(distance);
    orbitPosition.add(position);
  }
  
  void display() {
    //ellipse(orbitPosition.x, orbitPosition.y, radius * 2, radius * 2);
  }
}