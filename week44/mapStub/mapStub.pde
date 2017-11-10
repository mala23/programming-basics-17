import ptmx.*;

Ptmx map;
PImage smiley;
int x , y;

void setup() {
  size(800, 600);
  smiley = loadImage("smiley.png");
  map = new Ptmx(this, "crossroad.tmx");
  map.setDrawMode(CENTER);
  map.setPositionMode("MAP");
  x = int(map.getMapSize().x / 2);
  y = int(map.getMapSize().y / 2);
  imageMode(CENTER);
}

void draw(){
  background(map.getBackgroundColor());
  map.draw(x, y);
  image(smiley, width / 2, height / 2);
}

void keyPressed(){
  int prevX = x;
  int prevY = y;
  if(keyCode == LEFT) x -= 1;
  if(keyCode == RIGHT) x += 1;
  if(keyCode == UP) y -= 1;
  if(keyCode == DOWN) y += 1;
  PVector overTile = map.canvasToMap(x, y);
  switch(map.getTileIndex(0, round(overTile.x), round(overTile.y))){
    case 6: case 7: case 13: case 14: case 15: case 21: case 22: case 23: case 29:
      break;
    case 30: case 37: case 38: case 39: case 46: case 47:
      map.setTileIndex(0, round(overTile.x), round(overTile.y), 29);
      break;
    default:
      x = prevX;
      y = prevY;
  }
}
