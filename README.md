# EECS1710-Project-2-One-Button-Game

For my one button game, I made a vertical scrolling jump game
The main objective of the game is to dodge the obstacles


Controls:
- SPACEBAR is the only in game mechanic, which moves the player to the left or to the right
- mousePressed is only used to start the game in the menu screen and game over screen

Obstacles:
- obstacles are just black rectangles with a width between 150 and 250 and a constant height of 50
- in the init(); function, determines the position of the rectangle when it is drawn by generating a random number between 0 - 1 and storing it in float val (if val > 0.5 the x position is set to the right of the screen and if val < 0.5 the opposite happens
- when the game runs, the obstacles fall from the top of the screen to the bottom of the screen by a certain speed

- obstacle objects are stored in an arrayList
- millis() and int obsInterval determines when an obstacle is added to the arrayList (obsInterval begins at 1000ms or 1s and decreases to minimum of 200ms throught the game) 
- when the obstacle leaves the screen, it is removed from the arraylist using .remove() and a for loop that itterate the arraylist and checks if the obstacle is still in frame
- each time a obstacle is removed, 1 is added to a score counter (currentScore)
- obsInterval, which determines how fast a abostacle object is added, decreases when the score goes up, making the game harder

Player: 
- player is a simple 50 x 50 square 
- the gif effect was created using and array list of different images and a for loop that itterates between each image
- player rotates clockwise when moving to the right and rotates counter clockwise when moving to the left
- player us drawn between a pushMatrix(); and popMatrix(); so it can rotate
- Each position of the player is stored in an arrayList of PVectors called history
- A for loop then itterates throught the arrayList and draws the player image at each position 
- tint(); fades out each drawing 
- when the size of the arrayList becomes > 15, the oldest PVector is removed 

Walls:
- Using professor's prallaxer example, I was able to create two walls that look like they are continuously moving down, which gives the affect that the box is moving up the walls

Music and sound effcts:
- imported the processing sound library in order to add music and effects
- the song that is always playing was a poor attempt of a synthwave song produced by me
- the game over sound effect is a sound I got from a free sample pack that I manipulated using Ableton (I added reverb, a delay, and pitched it down)
- the jump sound effect is a swoosh and a laser sound, I layered and pitch manipulated in Abelton 


References:
- For the plater trails: https://www.youtube.com/watch?v=OssDengJICg&list=LL&index=1&ab_channel=ChaseStarr
- For the player gif: https://www.youtube.com/watch?v=0cTSfuYPu9U&list=LL&index=2&ab_channel=LenPelletier
- For the continuous moving walls: https://github.com/n1ckfg/Parallaxer
