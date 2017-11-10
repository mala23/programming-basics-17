/* -------------------------------------------------------------------------- //<>//
 * Hunters
 * --------------------------------------------------------------------------
 *  Colin Schmid
 *  09/11/2017
 * ----------------------------------------------------------------------------
 */

// game objects
Dean playerCharacter;
ArrayList<CrossroadsDemon> crossroadDemons;
ArrayList<Projectile> projectiles;

//game variables
boolean keyLeft = false;
boolean keyRight = false;
boolean keyUp = false;
boolean keyDown = false;
boolean shootLimit;
int gameStatus = 0;

//game constants
final int startScreen = 0;
final int playingGame = 1;
final int GameOver = 2;
final int gameWon = 3;
final color palette1 = color(69, 92, 123);
final color palette2 = color(218, 114, 126);
final color palette3 = color(255, 188, 103);
final color palette4 = color(104, 92, 121);

void setup() {
  size(800, 600);
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

void setupGame() {
  //instantiate all the game objects
  playerCharacter = new Dean();
  projectiles = new ArrayList<Projectile>();
  crossroadDemons = new ArrayList<crossroadDemons>();

  //randomly position crossroad-demons on map
  for (int i = 0; i < 6; i++) {
    PVector corssroadDemonsPosition = new PVector(random(width), random(height));
    float minimumDistance = crossroadDemonsPosition.dist(playerCharacter.position);
  }

  PVector crossroadDemonsDirection = new PVector(random(1), random(1));
  float diameter = 32;
  float speed = 2;
  float damper = 1;
  crossroadDemons.add(new crossroadDemon(crossroadDemonsPosition, crossroadDemonsDirection, diameter, speed, damper));
}

//*************
// game screens
//*************

void drawStartScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("Press <ENTER> to start\nPress <SPACE> to shoot", width/2, height/2);
}

void drawGameOverScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("GAME OVER\nPress ENTER to restart", width/2, height/2);
}

void drawGameWonScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("YOU WON!\nPress <ENTER> to restart", width/2, height/2);
}

void drawGame() {
  background(palette1);

  //call display function on all objects
  playerCharacter.display();
  for(CrossroadsDemon object : crossroadDemons) {
    object.display();
  }
  for(Projectile object : projectiles) {
    object.display();
  }

  //key control
  if (keyUp) {
    playerCharacter.updateSpeed();
  }
  if (keyRight) {
    playerCharacter.updateAngle(.05);
  }
  if (keyLeft) {
    playerCharacter.updateAngle(-.05);
  }

  //if all the crossroad-demons are gone, then game has been won
  if (crossroadDemons.size() == 0) {
    gameStatus = gameWon;
  }
  checkCollisions();
}
