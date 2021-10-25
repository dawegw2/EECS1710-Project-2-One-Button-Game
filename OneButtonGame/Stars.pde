class Star {
  PImage stars;
  PVector position;
  
  float starSize;
  float x;
  float y;
  float ySpeed = 0.5;
  float val;
  boolean star1; 

  Star() {
    val = random(1);
    if (val < 0.75) {
      star1 = true;
    } else {
      star1 = false;
    }
    starSize = 5;
    stars = loadImage("star.png");
    x = random(60, 400);
    y = random(-800, 0);
    position = new PVector(x, y);
    imageMode(CENTER);
  }

  void draw() {
    noStroke();
    fill(255, random(100, 150)); 
    tint(255, random(50, 150));
    if (star1) { //draws basic square star
      rect(position.x, position.y, starSize, starSize);
    } else { //draws second star
      image(stars, position.x, position.y);
    }
  }

  //moves stars down
  void update() {
    position.y += ySpeed;
  }
  
  //checks if star is still on screen and returns true when star leaves the screen
  boolean inFrame() {
    if (position.y > height) {
      return false;
    } else {
      return true;
    }
  }

  void run() {
    draw();
    update();
  }
}
