class Obstacle {
  PVector position;
  float moveSpeed = 15;
  float yMargin = 100;
  float val;
  float y = -100;
  float x = 75;
  float w;
  float h = 50;
  boolean inFrame = true;
  boolean collision = false;
  boolean left; 

  Obstacle() {
    val = random(1);
    if (val > 0.5) {
      x = width - 75;
      left = false;
    } else {
      x = 75;
      left = true;
    }
    //println(left);
    w = int(random(100, 250));
    position = new PVector(x, y);
    rectMode(CENTER);
  }

  //draws obstacle
  void display() {
    fill(0);
    rect(position.x, position.y, w, h, 10);
  }

  void move() {
    position.y = position.y + moveSpeed;
  }

  void update() {
    if (position.y > height + 50) {
      inFrame = false;
    }
  }

  void run() {
    display();
    move();
    update();
  }
}
