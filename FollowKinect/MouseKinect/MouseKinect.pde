// A Mover object
Mover mover;

KinectManager kinectManager;
int kinectX;
int kinectY;

void setup() {
  size(640, 360);
  mover = new Mover();

  // min & max threshold
  kinectManager = new KinectManager(new Kinect2(this), 480, 830);
}

void draw() {
  background(0);

  // Draw ellipse at center of pixels of the Kinect
  kinectManager.update();
  kinectManager.display();
  fill(150, 0, 255);
  ellipse(kinectManager.getAvgX(), kinectManager.getAvgY(), 64, 64);

  // Update the location of the move
  mover.update();
  // Display the Mover
  mover.display();
}
