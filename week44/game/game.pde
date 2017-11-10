/* -------------------------------------------------------------------------- //<>//
 * Asteroid
 * --------------------------------------------------------------------------
 *  Luke Franzke 
 *  01/09/2017 (m/d/y)
 * ----------------------------------------------------------------------------
 */

// game objects 
Ship myShip;
ArrayList<Asteroid> asteroids;
ArrayList<Torpedo> torpedos;
// game variables  
boolean keyLeft = false;
boolean keyRight = false;
boolean keyUp = false;
boolean shootLimit; // used to limit torpedos to one per click
int gameStatus = 0;

// game constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;
final color palette1 = color(69, 92, 123);
final color palette2 = color(218, 114, 126);
final color palette3 = color(255, 188, 103);
final color palette4 = color(104, 92, 121);


void setup()
{
  size(1000, 600); 
  //fullScreen(); 
  setupGame();
  noStroke();
}

void draw() {
  switch(gameStatus) {
  case startScreen:
    drawStartScreen();
    break;
  case playingGame:
    drawGame();
    break;
  case gameOver:
    drawGameOverScreen();
    break;
  case gameWon:
    drawGameWonScreen();
    break;
  }
}


void setupGame()
{
  //Creat instances of all the game objects 
  myShip = new Ship(width/2, height/2, 20, .1, .999);
  torpedos = new ArrayList<Torpedo>();
  asteroids = new ArrayList<Asteroid>();
  // Randomly position asteroids around the game 
  for (int i = 0; i < 6; i++) {
    PVector asteroidsPosition = new PVector(random(width), random(height));
    float minimumDistance =  asteroidsPosition.dist(myShip.position);
    // check that the game always starts with a minimum distance between player and asteroids
    while (minimumDistance <= 300) {
      asteroidsPosition.set(random(width), random(height));
      minimumDistance =  asteroidsPosition.dist(myShip.position);
    }
    PVector asteroidsDirection = new PVector(random(1), random(1));
    float diameter = random(30)+20;
    float speed = 2;
    float damper = 1;
    asteroids.add(new Asteroid(asteroidsPosition, asteroidsDirection, diameter, speed, damper));
  }
}


//*************
// game screens
//*************

void drawStartScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("PRESS ENTER TO START\nPRESS SPACE TO SHOOT", width/2, height/2);
}

void drawGameOverScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("GAME OVER\nPRESS ENTER TO RESTART", width/2, height/2);
}

void drawGameWonScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("YOU WON!\nPRESS ENTER TO RESTART", width/2, height/2);
}

void drawGame() {
  background(palette1);
  // call the display function on all objects 
  myShip.display();
  for (Asteroid object : asteroids) {
    object.display();
  }
  for (Torpedo object : torpedos) {
    object.display();
  }
  // key control
  if (keyUp) {
    myShip.updateSpeed();
  }
  if (keyRight) {
    myShip.updateAngle(.05);
  }
  if (keyLeft) {
    myShip.updateAngle(-.05);
  }
  // if all the asteroids are gone, then game has been won  
  if (asteroids.size() == 0) {
    gameStatus = gameWon;
  }
  checkCollisions();
}

//*************
//Collision Detection
//*************

void checkCollisions() {
  for (int i = 0; i < asteroids.size(); i++) {
    Asteroid object1  = asteroids.get(i);
    // check asteroid against ship
    if (object1.checkCollision(myShip)) {
      gameStatus = gameOver;
    }
    // check asteroid against torpedos
    for (int j = 0; j < torpedos.size(); j++) {
      Torpedo object2  = torpedos.get(j);
      if (!object2.display) {
        torpedos.remove(object2);
      } else if (object1.checkCollision(object2)) {
        asteroids.remove(object1);
        torpedos.remove(object2);
      }
    }
  }
};


//*************
// game events
//*************

void keyPressed() {

  if (keyCode == UP  ||key == 'W'||key == 'w') {
    keyUp = true;
  } 
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = true;
  } 
  if (keyCode == RIGHT || key == 'D'|| key== 'd') {
    keyRight = true;
  }
  if (key == ' ' && gameStatus == playingGame && shootLimit == false) {
    myShip.shoot();
    shootLimit = true;
  }
  if (key == ENTER) {
    if (gameStatus != playingGame) {
      setupGame();
      gameStatus = playingGame;
    }
  }
} 

void keyReleased() {
  if (keyCode == UP || key == 'W'|| key == 'w') {
    keyUp = false;
  } 
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = false;
  }
  if (keyCode == RIGHT || key == 'D'|| key == 'd') {
    keyRight = false;
  }
  if (key == ' ' && gameStatus == playingGame) {
    shootLimit = false;
  }
}