class Walls {
  //Reference 
  //Parallaxer expample from course wiki week 3
  float speed;
  PImage img;
  float spriteHeight;
  float startY, startY2, endY;
  boolean flip = false;
  PVector position, position2;

  Walls(PImage _img, float _speed, PVector _position) {
    img = _img;
    speed = _speed;
    position = _position;
    
    init();
  }
  
  Walls(String _url, float _speed, PVector _position) {
    img = loadImage(_url);
    speed = _speed;
    position = _position;
    
    init();
  }
  
  void init() {
    spriteHeight = 1000;
    startY = position.y;
    endY = startY + spriteHeight;
    startY2 = startY + spriteHeight;
    position2 = new PVector(startY2, 0);
  }
  
  void update() {
    position.y += speed;

    if (position.y > endY) {
      if (flip) {
        flip = false;
      } else {
        startY2 += spriteHeight;
        flip = true;
      }
  
      position = new PVector(position.x, startY);
    }
  }
  
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    image(img, 0, 0);
    image(img, position2.x, position2.y);
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }

}
