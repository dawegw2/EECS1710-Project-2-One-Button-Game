class User {
  //REFERENCE
  //trails - https://www.youtube.com/watch?v=OssDengJICg&list=LL&index=1&ab_channel=ChaseStarr
  //playerGif - https://www.youtube.com/watch?v=0cTSfuYPu9U&list=LL&index=2&ab_channel=LenPelletier
  PImage player, trail, playerdead;
  PImage[] playerGif;
  PVector startPosition, position, targetPos;
  ArrayList<PVector> history;

  int numFrames = 11;
  int f;
  int val = 0;
  
  float movementSpeed = 0.3;
  float w = 50;
  float h = 50;
  float xConstant = 74;
  float rot = 0;
  float rotInc = 10;
  
  boolean isRight = false;
  boolean alive;

  User() {
    playerGif = new PImage[numFrames];
    int i = 0;
    while (i < numFrames) {
      playerGif[i] = loadImage("box" + i + ".png");
      i++;
    }
    history = new ArrayList<PVector>();
    init();
    trail = loadImage("box12.png");
    playerdead= loadImage("boxdead.png");
    rectMode(CENTER);
    imageMode(CENTER);
  }

  void init() {
    alive = true;
    startPosition = new PVector(xConstant, height - 150);
    position = startPosition.copy();
    targetPos = position.copy();
  }

  void draw() {
    if (alive) {
      fill(255);
    } else {
      fill(255, 0, 0);
      fullSong.stop();
      gameOverSound.play();

      if (position.y < height) {
        position.y += 50;
      }
    }
    
    //image trails
    for (int i = 0; i < history.size(); i++) {
      PVector current = history.get(i);
      tint(255, i * 10);
      image(trail, current.x, current.y, i*3, i*3);
    }
    
    pushMatrix();
    translate(position.x, position.y);
    rotate(radians(rot)); //rotates the box
    noTint();
    image(playerGif[f], 0, 0);
    //changes player image when player is dead
    if (!alive) {
      image(playerdead, 0, 0);
    }
    popMatrix();
    
    if (frameCount % 5 == 0) {
      f = f + 1;
    }
    if (f == numFrames) {
      f = 0;
    }

    flip(); //flips box by changing rotation value
  }

  void update() { 
    position.lerp(targetPos, movementSpeed);

    PVector v = new PVector(position.x, position.y);
    history.add(v);

    if (history.size() > 15) {
      history.remove(0);
    }
  }

  void checkSide() {
    if (position.x > width/2 + 50) {
      isRight = true;
      rotInc = 10;
    }
    if (position.x < width/2 - 50) {
      //x = 0;
      isRight = false;
      rotInc = -10;
    }
  }

  //moves player
  void move() {
    if (!isRight) {
      moveRight();
    } 
    if (isRight) { 
      moveLeft();
    }
  }

  //rotates player 90 degrees evertime they jump
  void flip() {
    if (position.x > width/2) {
      if (rot < 90) {
        rot += rotInc;
      }
    }
    if (position.x < width/2) {
      if (rot > 0) {
        rot -= 10;
      }
    }
  }

  void moveRight() {
    targetPos.x = width - xConstant;
  }

  void moveLeft() {
    targetPos.x = xConstant;
  }

  void run() {
    draw(); 
    update();
    checkSide();
    //println(isRight);
  }
}
