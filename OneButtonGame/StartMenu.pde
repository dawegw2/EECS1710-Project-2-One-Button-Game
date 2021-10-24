class StartPage {
  PFont font;
  String message = ("SPACEBAR to Jump");
  String message2 = ("click anywhere to begin");

  StartPage() {
  }
  void screen() {
    //fill(0);
    //rect(100, 100, width/2, height/2);
  }
  void display() {
    fill(255);
    font = createFont("pixel.ttf", 100);
    textFont(font);
    textSize(30);
    text(message, width/2, height - 200);
    textSize(20);
    text(message2, width/2, height - 150);
  }
} 

class GameOverPage {
  PFont messagefont;
  String message = ("GAME OVER");
  String message2;
  String message3 = ("Click anywhere to play again");


  GameOverPage() {
  }

  void display() {
    fill(255);
    //messagefont = createFont("Arial", 25);
    textSize(50);
    text(message, width/2, height/2);
    
    textSize(40);
    message2 = ("Score: " + currentScore);
    text(message2, width/2, height/2 + 50);
    
    textSize(20);
    text(message3, width/2, height/2 + 100);
    
    gameOver = true;
    noLoop();
  }
} 
