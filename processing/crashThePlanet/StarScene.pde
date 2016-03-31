import java.util.Random;

public static int randInt(int min, int max) {
  Random rand = new Random();
  int randomNum = rand.nextInt((max - min) + 1) + min;
  return randomNum;
}

class StarScene extends Demo {
  private int timestep;
  private int scene_width;
  private int scene_height;

  private int num_stars;
  private int new_star_min_x;
  private int new_star_max_x;
  private int new_star_min_y;
  private int new_star_max_y;

  private ArrayList<Star> stars;
  
  StarScene() {
    stars = new ArrayList<Star>();
    loadConfig("starfield-config.xml");
    setFrameRate(30);
    for (int i = 0; i < 20; i++) {
      update();
    }
  }
  
  void loadConfig(String filename) {
    XML xml = loadXML(filename);
    timestep = xml.getChild("scene").getInt("timestep");
    scene_width = xml.getChild("scene").getInt("width");
    scene_height = xml.getChild("scene").getInt("height");
    num_stars = xml.getChild("stars").getInt("number");
    
    int center_x = scene_width / 2;
    int center_y = scene_height / 2;
    int star_spread_x = (int)(xml.getChild("stars").getFloat("spread_x") * scene_width) / 2;
    int star_spread_y = (int)(xml.getChild("stars").getFloat("spread_y") * scene_height) / 2;
    new_star_min_x = center_x - star_spread_x;
    new_star_max_x = center_x + star_spread_x;
    new_star_min_y = center_y - star_spread_y;
    new_star_max_y = center_y + star_spread_y;
  }
  
  int scene_width() {
    return scene_width;
  }
  int scene_height() {
    return scene_height;
  }
  
  void update() {
    removeOldStars();
    updateList(stars);
    addStars(needNewStars());
  }
  
  void display() {
    displayList(stars);
  }
  
  int needNewStars() {
    return Math.max(0, num_stars - stars.size());
  }
  
  void addStars(int stars_needed) {
    for (int x = 0; x < stars_needed; x++) {
      PVector star_position = new PVector(randInt(new_star_min_x, new_star_max_x),
        randInt(new_star_min_y, new_star_max_y));
      float star_heading = new PVector(star_position.x - scene_width / 2, star_position.y - scene_height / 2).heading();
      float star_mag = new PVector(star_position.x - scene_width / 2, star_position.y - scene_height / 2).mag();
      PVector star_velocity = PVector.fromAngle(star_heading).mult(star_mag / 40.0);
      Star star_to_add = new Star(star_position, star_velocity);
      stars.add(star_to_add);
    }
  }
  
  boolean isOutOfBounds(Star s) {
    if (s.getPositionX() > scene_width) return true;
    if (s.getPositionX() < 0) return true;
    if (s.getPositionY() > scene_height) return true;
    if (s.getPositionY() < 0) return true;
    return false;
  }
  
  void removeOldStars() {
    for (int x = 0; x < stars.size(); x++) {
      Star a_star = stars.get(x);
      if (isOutOfBounds(a_star)) {
        stars.remove(x);
      }
    }
  }
  
  void updateList(ArrayList<? extends canUpdate> theList) {
    for (int x = 0; x < theList.size(); x++) {
      theList.get(x).update(timestep);
    }
  }
  
  void displayList(ArrayList<? extends canDisplay> theList) {
    for (int x = 0; x < theList.size(); x++) {
      theList.get(x).display();
    }
  }
  
}