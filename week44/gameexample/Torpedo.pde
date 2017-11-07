class Torpedo extends GameObject {
  int id;
  Torpedo(PVector position, PVector direction)
  {
    super(position, direction, 7, 10, 1);   // position,  direction,  diameter, speed, damper
  }

  void display()
  {
    super.display();
    if (display) {
      pushStyle();
      fill(palette2);
      noStroke();
      ellipse(position.x, position.y, diameter, diameter);
      popStyle();
    }
  }
  void screenWrap() {
    // overide screenWrap and hide torpedos if they are off screen 
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {
      display = false;
    }
  }
}