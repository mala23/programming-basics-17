PShape elShape;
PShape warningShape;
float rotAngle = 0.0;

void setup()
{
  size(600, 600);
  elShape = loadShape("High_voltage_warning.svg");
  warningShape = loadShape("Achtung.svg");
  shapeMode(CENTER);
  smooth();
}

void draw()
{
  background(255);
  pushMatrix();
    translate(width * .5, height * .5);
    rotate(rotAngle);
    shape(elShape,0,0,200,200);
  popMatrix();
  rotAngle += .01;

  shape(warningShape, mouseX, mouseY, 100, 100);
}
