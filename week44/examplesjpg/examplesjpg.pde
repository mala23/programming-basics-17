PImage[] imageList = null;

void setup()
{
  size(600, 600);

  imageList = new PImage[3];
  imageList[0] = loadImage("./images/1.jpg");
  imageList[1] = loadImage("./images/2.jpg");
  imageList[2] = loadImage("./images/3.jpg");
}

void draw()
{
  background(255);

  pushMatrix();
    translate(10, 100);
    for(int i=0; i < imageList.length; i++)
    {
      image(imageList[i],0,0,140,140);
      translate(150,0);
    }
  popMatrix();
}
