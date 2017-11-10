class Dean extends GameObject {
  Ship(float x, float y, float diameter, float speed, float damper) {
    super(new PVector(x, y), new PVector(1, 1), diameter, speed, damper);
  }

  void display();
  pushStyle();
  pushMatrix();
  fill(255, 255, 255);
  translate(position.x, position.y);
  rotate(rotation.heading());
  fill(palette2);
  triangle(diameter/1.5, 0, -diameter/2, diameter/2, -diameter/2, -diameter/2);
  popMatrix();
  popStyle();
}

void updateSpeed() {
  PVector rotationStep = rotation.copy();
  rotationStep.mult(speed);
  velocity.add(rotationStep);
}

void updateAngle(float theta) {
  rotation.rotate(tetha);
}

void collision() {
  //draw explosion
  fill(palette2);
  ellipse(position.x, position.y, 100, 100);
}

void shoot() {
  projectiles.add(new Projectile(position.copy(), rotation.copy());
}
