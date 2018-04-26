abstract class SpringyShape {
  // ----------------------------------------------------------------
  // Variables
  
  // Springs
  Spring x_spring, y_spring, theta_spring;

  // Screen values
  float tempxpos, tempypos, temptheta;
  
  int sizeX;
  int sizeY;

  boolean over = false;
  boolean move = false;

  SpringyShape[] friends;
  int me;

  // Counters for when to randomize the next position or rotation
  float next_pos_countDown = 0; // When this is 0, randomize next position
  float next_theta_countDown = 0;

  // ----------------------------------------------------------------
  // Constructor
  SpringyShape(float x, float y, int sizeX, int sizeY, float d, float m, 
    float k_in, float rotation, SpringyShape[] others, int id) {

    x_spring = new Spring(x, m, k_in, d);  
    y_spring = new Spring(y, m, k_in, d);
    theta_spring = new Spring(rotation, m, 0.1, 0.99);

    this.sizeX = sizeX;
    this.sizeY = sizeY;

    friends = others;
    me = id;
  }

  // ----------------------------------------------------------------
  // For Subclasses to override or implement
  abstract void drawShape(float x, float y, float shapeWidth, float shapeHeight);
  abstract void fillShape(boolean hasMouseOver);

  boolean shouldRotate() {
    return true;
  }
 
  // ----------------------------------------------------------------
  // Lifecycle
  void update() {
    // Set new position target
    if (move) {
      x_spring.setTargetValue(mouseX);
      y_spring.setTargetValue(mouseY);
    } else {

      if (next_pos_countDown <= 0) {
        next_pos_countDown = random(30, 60);

        float next_posx = x_spring.getRestValue() + random(-5, 5);
        float next_posy = y_spring.getRestValue()  + random(-5, 5);

        x_spring.setTargetValue(next_posx);
        y_spring.setTargetValue(next_posy);
      } else {
        next_pos_countDown -= 1;
      }
    }

    // Set new theta target
    if (next_theta_countDown <= 0) {
      next_theta_countDown = random(30, 60);

      float next_rotation = theta_spring.getRestValue() + random(-0.1, 0.1);

      theta_spring.setTargetValue(next_rotation);
    } else {
      next_theta_countDown -= 1;
    }

    // Update the new position and theta
    tempxpos = x_spring.applyForceTowardsTarget();
    tempypos = y_spring.applyForceTowardsTarget();
    temptheta = theta_spring.applyForceTowardsTarget();

    // Is there an mouseover event for this shape?
    over = ((overEvent() || move) && !otherOver());
  }

  // Test to see if mouse is over this shape
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
    for (int i=0; i<friends.length; i++) {
      if (i != me) {
        if (friends[i].over == true) {
          return true;
        }
      }
    }
    return false;
  }

  void display() {
    fillShape(over);

    pushMatrix();
    translate(tempxpos, tempypos);
    if (shouldRotate()) {
      rotate(temptheta);
    }
    drawShape(0, 0, sizeX, sizeY);
    popMatrix();
  }

  void pressed() {
    if (over) {
      move = true;
    } else {
      move = false;
    }
  }

  void released() {
    move = false;
    x_spring.resetTargetValue();
    y_spring.resetTargetValue();
  }
}
