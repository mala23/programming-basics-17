PVector pos;
PVector targetPos;
PVector mousePos;
void setup() {
  size(1000, 600);
  fill(0);
  pos = new PVector(0, 0);
  targetPos = new PVector(0, 0);
  mousePos = new PVector(width/2, height/2);
}

void draw() {
  background(255);
  targetPos.set(mousePos);
  targetPos.sub(pos);
  targetPos.mult(.2);
  pos.add(targetPos);
  ellipse(pos.x, pos.y, 60, 60);
}

void mousePressed() {
  mousePos.set(mouseX, mouseY);
};
