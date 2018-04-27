import org.openkinect.processing.*;

class KinectManager {

  // Kinect Library object
  private Kinect2 kinect2;
  private PImage img;
  private float minThresh;
  private float maxThresh;
  private float avgX = 0;
  private float avgY = 0;

  float getAvgX() {
    return avgX;
  }

  float getAvgY() {
    return avgY;
  }

  KinectManager(Kinect2 kinect2, float minThresh, float maxThresh) {
    this.kinect2 = kinect2;
    this.minThresh = minThresh;
    this.maxThresh = maxThresh;
    setupKinect();
  }

  private void setupKinect() {
    kinect2.initDepth();
    kinect2.initDevice();
    img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  }

  // Put in draw method
  void update() {
    img.loadPixels();

    minThresh = map(50, 0, width, 0, 4500);
    maxThresh = map(50, 0, height, 0, 4500);

    // Get the raw depth as array of integers
    int[] depth = kinect2.getRawDepth();

    float sumX = 0;
    float sumY = 0;
    float totalPixels = 0;

    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {
        int offset = x + y * kinect2.depthWidth;
        int d = depth[offset];

        if (d > minThresh && d < maxThresh && x > 100) {
          img.pixels[offset] = color(255, 0, 150);

          sumX += x;
          sumY += y;
          totalPixels++;

          //find average to find center of floating points
        } else {
          img.pixels[offset] = color(0);
        }
      }
    }

    img.updatePixels();

    avgX = sumX / totalPixels;
    avgY = sumY / totalPixels;
  }

  // Put in draw method
  void display() {
    image(img, 0, 0);

    //fill(255);
    //textSize(32);
    //text(minThresh + " " + maxThresh, 10, 64);
  }
}
