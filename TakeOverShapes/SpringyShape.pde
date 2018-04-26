class RectSpring extends SpringyShape {
  color aColor;
    
  RectSpring(color aColor, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, int(random(20, 150)), 15, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.aColor = aColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    rect(x - shapeWidth/2, y - shapeHeight/2, shapeWidth, shapeHeight);
  }

  void fillShape() {
    fill(aColor);
  }
}

class CircleSpring extends SpringyShape {
  color aColor;

  CircleSpring(color aColor, float x, float y, int radius, SpringyShape[] springs, int id) {
    super(x, y, radius, radius, 0.98, random(15, 25), 0.1, 0, springs, id);
    this.aColor = aColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    ellipse(x, y, shapeWidth, shapeHeight);
  }

  void fillShape() {
    fill(aColor);
  }
}

abstract class SpringyShape {
  // Screen values
  float xpos, ypos;
  float tempxpos, tempypos, temptheta;
  int sizeX;
  int sizeY;
  
  boolean over = false;
  boolean move = false;


  // Spring simulation constants
  float mass;       // Mass
  float k = 0.2;    // Spring constant
  float damp;       // Damping
  float rest_posx;  // Rest position X
  float rest_posy;  // Rest position Y

  // Rotation spring constants
  float theta;
  float rest_theta;
  float rotation_k = 0.1;
  float rotation_damp = 0.99;

  // Spring simulation variables
  //float pos = 20.0; // Position
  float velx = 0.0;   // X Velocity
  float vely = 0.0;   // Y Velocity
  float accel = 0;    // Acceleration
  float force = 0;    // Force

  // Rotation Spring Variables
  float velTheta = 0.0; // Angular velocity w

  SpringyShape[] friends;
  int me;

  // Randomize Next Position
  float next_posx;
  float next_posy;
  float next_pos_counter = 0; // When this is 0, randomize the next position

  // Randomize Next Rotation
  float next_rotation;
  float next_rotation_counter = 0;

  // Constructor
  SpringyShape(float x, float y, int sizeX, int sizeY, float d, float m, 
    float k_in, float rotation, SpringyShape[] others, int id) {
    xpos = tempxpos = x;
    ypos = tempypos = y;

    rest_posx = x;
    rest_posy = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    damp = d;
    mass = m;
    k = k_in;

    friends = others;
    me = id;

    theta = temptheta = rotation;
  }

  void update() {
    if (move) {
      rest_posy = mouseY;
      rest_posx = mouseX;
    } else {

      if (next_pos_counter <= 0) {
        next_pos_counter = random(30, 60);
        next_posx = xpos + random(-5, 5);
        next_posy = ypos + random(-5, 5);
      } else {
        next_pos_counter -= 1;
      }

      rest_posx = next_posx;
      rest_posy = next_posy;

      //Randomize rest_posx and rest_posy => starting position + random(range)
    }

    if (next_rotation_counter <= 0) {
      next_rotation_counter = random(30, 60);
      next_rotation = theta + random(-0.1, 0.1);
    } else {
      next_rotation_counter -= 1;
    }
    rest_theta = next_rotation;

    force = -k * (tempypos - rest_posy);  // f=-ky
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m
    vely = damp * (vely + accel);         // Set the velocity
    tempypos = tempypos + vely;           // Updated position

    force = -k * (tempxpos - rest_posx);  // f=-ky
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m
    velx = damp * (velx + accel);         // Set the velocity
    tempxpos = tempxpos + velx;           // Updated position

    force = -rotation_k * (temptheta - rest_theta);
    accel = force / mass;
    velTheta = damp * (velTheta + accel);
    temptheta = temptheta + velTheta;

    if ((overEvent() || move) && !otherOver() ) {
      over = true;
    } else {
      over = false;
    }
  }

  // Test to see if mouse is over this shape
  //abstract boolean overEvent
  boolean overEvent() {
    return hitTest(mouseX, mouseY, tempxpos, tempypos);
  }

    // Hit test within a circle
  boolean hitTest(float hitX, float hitY, float currentX, float currentY) {
    float disX = currentX - hitX;
    float disY = currentY - hitY;
    return (sqrt(sq(disX) + sq(disY)) < sizeX/2 );
  }

  // Hit test within a rectangle
  //boolean hitTest(float hitX, float hitY, float currentX, float currentY) {
  //   return (hitX >= currentX
  //        && hitX <= currentX + sizeX
  //        && hitY >= currentY
  //        && hitY <= currentY + sizeY);
  //}

  // Make sure no other springs are active
  boolean otherOver() {
    for (int i=0; i<numberOfShapes; i++) {
      if (i != me) {
        if (friends[i].over == true) {
          return true;
        }
      }
    }
    return false;
  }

  void display() {
    if (over) {
      fill(153);
    } else {
      fillShape();
    }

    pushMatrix();
    translate(tempxpos, tempypos);
    rotate(temptheta);
    drawShape(0, 0, sizeX, sizeY);
    popMatrix();
  }

  abstract void drawShape(float x, float y, float shapeWidth, float shapeHeight);
  abstract void fillShape();

  void pressed() {
    if (over) {
      move = true;
    } else {
      move = false;
    }
  }

  void released() {
    move = false;
    rest_posx = xpos;
    rest_posy = ypos;
  }
}
