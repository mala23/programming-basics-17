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
}
