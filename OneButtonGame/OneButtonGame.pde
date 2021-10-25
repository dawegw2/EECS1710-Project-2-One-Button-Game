import processing.sound.*;
SoundFile fullSong, gameOverSound, jump1, jump2;

PFont font;
User player;
StartPage startScreen;
GameOverPage endScreen;
Walls leftWall, rightWall;
Backdrop backdrop;
ArrayList<Obstacle> obs;
ArrayList<Star> stars;

int markTime = 0;
int obsInterval = 1000; //obstacle spawn timer

int currentScore = 0;
int numStars = 20;

boolean debug = false;
boolean gameRunning = false;
boolean gameOver = false;
boolean startMenu = true;

void setup() {
  size(500, 800, P2D);

  noSmooth();
  leftWall = new Walls("leftwall.png", 15, new PVector(0, height/2));
  rightWall = new Walls("rightwall.png", 15, new PVector(width, height/2));

  font = createFont("Arial", 50);
  textFont(font);
  textAlign(CENTER);

  player = new User();
  startScreen = new StartPage();
  endScreen = new GameOverPage();
  backdrop = new Backdrop(int(random(3)));

  //song
  fullSong = new SoundFile(this, "sound/Synthwaveattempt.wav");
  fullSong.jump(21.33);
  //soound effects
  gameOverSound = new SoundFile(this, "sound/gameover.wav");
  jump1 = new SoundFile(this, "sound/jump1.wav");
  jump2 = new SoundFile(this, "sound/jump2.wav");

  obs = new ArrayList<Obstacle>();
  stars = new ArrayList<Star>();

  noLoop();
}

void draw() {
  backdrop.draw();
  int s = second();
  int t = millis();
  //println(t);

  //adds stars to arraylist
  for (int i = 0; i < numStars; i++) {
    if (stars.size() < 20) {
      if (s % 5 == 0) {   
        stars.add(new Star());
      }
    }
  }

  //creates and runs stars
  for (int i = stars.size() - 1; i >= 0; i--) { 
    Star star = stars.get(i);
    star.run();
    if (obsInterval < 300) {
      star.ySpeed = 1.5;
    }
    
    //when star leaves frame, it is removed from the arraylist
    if (!star.inFrame()) {
      stars.remove(i);
    }
  }

  //create a new obstacle every obstacle interval which decreases as time goes on
  if (t > markTime + obsInterval && gameRunning) {
    obs.add(new Obstacle());
    markTime = t;
  }

  //speeds up how fast obstacles spawn depending on the current score
  if (currentScore < 30) {
    obsInterval = 800;
  }
  if (currentScore > 30 && currentScore < 60) {
    obsInterval = 600;
  }
  if (currentScore > 60 && currentScore < 150) {
    obsInterval = 400;
  }
  if (currentScore > 150 && currentScore < 230) {
    obsInterval = 300;
  }
  if (currentScore > 230) {
    obsInterval = 200;
  }

  println(obsInterval + "," + t);

  //obstacles
  for (Obstacle obstacle : obs) {
    obstacle.run();
    
    //debugger
    /*
    if (debug) {
      stroke(0, 255, 0);
      line(obstacle.position.x, obstacle.position.y, player.position.x, player.position.y);
    }
    */
    float distX = abs((player.position.x + player.w/2) - (obstacle.position.x + obstacle.w/2));
    float distY = abs((player.position.y + player.h/2) - (obstacle.position.y + + player.h/2));
    float halfWidth = (player.w/2) + (obstacle.w/2);
    float halfHeight = (player.h/2) + (obstacle.h/2);

    //right obstacle colllisions
    if (!obstacle.left && player.isRight) {
      if (player.position.x > obstacle.position.x - (obstacle.w / 2) || distX < halfWidth) {
        if (distY < halfHeight) {
          player.alive = false;
        }
      } else {
        player.alive = true;
      }
    }

    //left obstacle collisons
    // && dist(player.position.x, player.position.y, obstacle.position.x, obstacle.position.y) <= 50
    if (obstacle.left && !player.isRight) {
      if (player.position.x < obstacle.position.x + (obstacle.w / 2) || distX < halfWidth) {
        if (distY < halfHeight) {
          player.alive = false;
        }
      } else {
        player.alive = true;
      }
    }
  }

  //removes obstacle once it exits the screen
  for (int i = obs.size()- 1; i >= 0; i--) {
    if (!obs.get(i).inFrame) {
      obs.remove(0);
      currentScore += 1;
    }
  }
  //println(obs.size());

  //player
  player.run();

  //wall parallax
  imageMode(CENTER);
  pushMatrix();
  leftWall.run();
  rightWall.run();
  popMatrix();

  //shows score counter when game is running
  if (gameRunning) {
    fill(0); //score color
    textSize(50);
    text(currentScore, width/2, 75);
  }
  //start menu
  if (startMenu) {
    startScreen.screen();
    startScreen.display();
  }
  //displays game over screen when player dies
  if (!player.alive) {
    endScreen.display();
  }
}

//controls
void keyPressed() {
  if (gameRunning) {
    if (key == ' ') {
      player.move(); //moves player
      if (!player.isRight) {
        jump1.play();
      } else {
        jump2.play();
      }
    }
  }
  /*
  //debugger controls
  if (key == 'b') {
    debug = true;
  }
  if (key == 'v') {
    debug = false;
  }
  */
}

void mousePressed() {
  if (!gameRunning) {
    loop();
    gameRunning = true;
    startMenu = false;
    fullSong.loop(); //starts song from beginning
  }

  if (gameOver) {
    gameRunning = false;
    gameOver = false;
    startMenu = true;
    markTime = 0;

    obsInterval = 1000;

    numStars = 20;
    currentScore = 0;
    setup();
    loop();
  }
}
