import org.openkinect.processing.*;
// Kinect Library object
Kinect2 kinect2;
PImage img;
float minThresh = 480;
float maxThresh = 830;
float avgX = 100;
float avgY = 100;
// A Mover object
Mover mover;

void setupKinect() {
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
}

void drawKinect() {
 background(0);

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
  image(img, 0, 0);
  
  avgX = sumX / totalPixels;
  avgY = sumY / totalPixels;
  fill(150,0,255);
  ellipse(avgX, avgY, 64, 64); //draw ellipse at center of pixels
  
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
}

void setup() {
  size(640,360);
  mover = new Mover();
  
  setupKinect();
}

void draw() {
  background(0);
  drawKinect();
  
  // Update the location
  mover.update();
  // Display the Mover
  mover.display(); 
}




/**
 * Acceleration with Vectors 
 * by Daniel Shiffman.  
 * 
 * Demonstration of the basics of motion with vector.
 * A "Mover" object stores location, velocity, and acceleration as vectors
 * The motion is controlled by affecting the acceleration (in this case towards the mouse)
 */


class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;

  Mover() {
    // Start in the center
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed = 5;
  }

  void update() {
    
    // Compute a vector that points from location to mouse
    
    println("mouse: (" + mouseX + ", " + mouseY + ") avg: (" + avgX + ", " + avgY + ")");
    PVector mouse = new PVector(int(avgX),int(avgY));
    PVector acceleration = PVector.sub(mouse,location);
    // Set magnitude of acceleration
    acceleration.setMag(0.2);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(127);
    println("ellipse location: " + location.x + ", " + location.y);
    ellipse(location.x,location.y,48,48);
  }

}
