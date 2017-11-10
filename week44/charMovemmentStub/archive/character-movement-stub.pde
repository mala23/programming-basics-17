import ptmx.*;

Ptmx map;
int x, y;

void setup() {
  size(800, 600);
  map = new Ptmx(this, "crossroad.tmx");
  map.setDrawMode(CENTER);
  map.setPositionMode("MAP");
  x = int(map.getMapSize().x / 2);
  y = int(map.getMapSize().y / 2);
  imageMode(CENTER);
}

void draw() {
  map.draw(x, y);
}

void keypressed() {
  int prevX = x;
  int prevY = y;
  if(keyCode == LEFT) x--;
  if(keyCode == RIGHT) x++;
  if(keyCode == UP) y--;
  if(keyCode == DOWN) y++;
  switch(map.getTileIndex(0, x, y)) {
    case 6: case 7: case 13: case 14: case 15: case 21: case 22: case 23: case 29:
      break;
    case 30: case 37: case 38: case 39: case 46: case 47:
      map.setTileIndex(0, x, y, 29);
      break;
    default:
      x = prevX;
      y = prevY;
  }
}
