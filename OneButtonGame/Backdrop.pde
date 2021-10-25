class Backdrop {
  PImage backdrop;
  int val;

  Backdrop(int _val) {
    //println(_val);
    val = _val;
    if (val == 0) {
      backdrop = loadImage("background.png");
    }
    if (val == 1) {
      backdrop = loadImage("background2.png");
    }
    if (val == 2) {
      backdrop = loadImage("background3.png");
    }

    backdrop.resize(488, 2000);
  }

  void draw() {
    image(backdrop, width/2, (height/2));
  }
}
