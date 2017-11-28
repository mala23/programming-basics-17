float t;

void setup() {
  background(20);
  size(500, 500);
}

void draw () {
  stroke(255);
  strokeWeight(6);
  translate(width / 2, height / 2);
  point(x(t), y(t));
  t++;
}

float x(float t) {
  return 0;
}

float y(float t) {
  return 0;
}
