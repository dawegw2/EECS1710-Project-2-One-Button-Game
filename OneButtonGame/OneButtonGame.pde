PFont font;
PImage backdrop;
User player;
StartPage startScreen;
GameOverPage endScreen;
ArrayList<Obstacle> obs;
ArrayList<Star> stars;

int markTime = 0;

int obsInterval = 1000;
int enemyInterval = 4000;
int speedInterval = 5000;
int powerInterval = 4000;

int currentScore = 0;
int numStars = 20;

int timer;

boolean debug = false;
boolean gameRunning = false;
boolean gameOver = false;
boolean startMenu = true;

void setup() {
  size(500, 800, P2D);
  font = createFont("Arial", 50);
  textFont(font);
  textAlign(CENTER);

  backdrop = loadImage("background2.png");
  backdrop.resize(488, 2000);

  player = new User();
  startScreen = new StartPage();
  endScreen = new GameOverPage();

  obs = new ArrayList<Obstacle>();
  stars = new ArrayList<Star>();

  noLoop();
}

void draw() {
  background(127);

  //noTint();
  image(backdrop, width/2, (height/2));
  int s = second();
  int t = millis();
  println(t);

  //currentScore = int(t/10);
  for (int i = 0; i < numStars; i++) {
    if (stars.size() < 20) {
      if (s % 5 == 0) {   
        stars.add(new Star());
      }
    }
  }

  //stars
  for (int i = stars.size() - 1; i >= 0; i--) { 
    Star star = stars.get(i);
    star.run();
    if (obsInterval < 300) {
      star.ySpeed = 1.5;
    }

    if (!star.inFrame()) {
      stars.remove(i);
    }
  }

  for (int i = 0; i < s; i++) {
    timer = timer + 1;
  } 

  //create a new obstacle every obstacle interval which decreases as time goes on
  if (t > markTime + obsInterval && gameRunning) {
    obs.add(new Obstacle());
    markTime = t;
  }

  //speeds up how fast obstacles spawn 
  for (int i = 0; i < obs.size(); i++) {
    if (t % 500 == 0 && gameRunning) {
      if (obsInterval > 300) {
        obsInterval -= 100;
      }

      if (currentScore > 150) {
        obsInterval = 200;
      }

      //println(obs.get(i).moveSpeed + " " + obsInterval + "," + t);
    }
  }

  for (Obstacle obstacle : obs) {
    obstacle.run();

    if (debug) {
      stroke(0, 255, 0);
      line(obstacle.position.x, obstacle.position.y, player.position.x, player.position.y);
    }

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

  player.run();

  fill(0);  //wall color
  rect(0, height/2, 100, height);
  rect(width, height/2, 100, height);


  if (gameRunning) {
    fill(0); //score color
    textSize(50);
    text(currentScore, width/2, 75);
  }

  if (startMenu) {
    startScreen.screen();
    startScreen.display();
  }

  if (!player.alive) {
    endScreen.display();
  }
}

//controls
void keyPressed() {
  if (key == ' ') {
    player.press(); //moves player
  }
  if (key == 'b') {
    debug = true;
  }
  if (key == 'v') {
    debug = false;
  }
}

void mousePressed() {
  if (!gameRunning) {
    loop();
    gameRunning = true;
    startMenu = false;
  }

  if (gameOver) {
    gameRunning = false;
    gameOver = false;
    startMenu = true;
    //startScreen.display();
    markTime = 0;

    obsInterval = 1000;
    enemyInterval = 4000;
    speedInterval = 5000;
    powerInterval = 4000;

    numStars = 20;
    currentScore = 0;
    setup();
    println(obsInterval);
    loop();
  }
}
