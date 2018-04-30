abstract class SpringyShape {
  // Variables -------------------------------------------------

  color fillColor = color(200);
  private color highlightColor = color(113, 242, 235);
  
  // Springs
  Spring xSpring, ySpring, thetaSpring;

  // Screen values
  float centerX, centerY, pivotTheta;
  int sizeX;
  int sizeY;

  boolean shouldShowOverEvent = false;
  boolean isMoving = false;

  SpringyShape[] friends;
  int me;

  // Counters for when to randomize the next position or rotation
  float next_pos_countDown = 0; // When this is 0, randomize next position
  float next_theta_countDown = 0;

  // Constructor -------------------------------------------------
  SpringyShape(float x, float y, int sizeX, int sizeY, float d, float m, 
    float k_in, float rotation, SpringyShape[] others, int id) {

    xSpring = new Spring(x, m, k_in, d);  
    ySpring = new Spring(y, m, k_in, d);
    thetaSpring = new Spring(rotation, m, 0.1, 0.99);

    this.sizeX = sizeX;
    this.sizeY = sizeY;

    friends = others;
    me = id;
  }

  private void fillShape(boolean hasMouseOver) {
    if (hasMouseOver) {
      fill(highlightColor);
    } else {
      fill(fillColor);
    }
  }

  // For Subclasses to override or implement ----------------------------
  abstract void drawShape(float x, float y, float shapeWidth, float shapeHeight);

  boolean shouldRotate() {
    return true;
  }
 
  // Lifecycle ----------------------------------------------------------------
  void update() {
    // Set new position target
    if (isMoving) {
      xSpring.setTargetValue(mouseX);
      ySpring.setTargetValue(mouseY);
      
    } else {
      if (next_pos_countDown <= 0) {
        next_pos_countDown = random(30, 60);

        float next_posx = xSpring.getRestValue() + random(-5, 5);
        float next_posy = ySpring.getRestValue()  + random(-5, 5);

        xSpring.setTargetValue(next_posx);
        ySpring.setTargetValue(next_posy);
      } else {
        next_pos_countDown -= 1;
      }
    }

    // Set new theta target
    if (next_theta_countDown <= 0) {
      next_theta_countDown = random(30, 60);

      float next_rotation = thetaSpring.getRestValue() + random(-0.1, 0.1);

      thetaSpring.setTargetValue(next_rotation);
    } else {
      next_theta_countDown -= 1;
    }

    // Update the new position and theta
    centerX = xSpring.applyForceTowardsTarget();
    centerY = ySpring.applyForceTowardsTarget();
    pivotTheta = thetaSpring.applyForceTowardsTarget();

    // Should we display the mouseover event on this shape?
    shouldShowOverEvent = ((hasOverEvent() || isMoving) && !otherOver());
  }

  // Is mouse is hovering over this shape?
  boolean hasOverEvent() {
    return hitTest(mouseX, mouseY, centerX, centerY, sizeX/2);
  }

  // Hit test within a circle
  private boolean hitTest(float hitX, float hitY, float currentX, float currentY, float radius) {
    float disX = currentX - hitX;
    float disY = currentY - hitY;
    return (sqrt(sq(disX) + sq(disY)) < radius);
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
        if (friends[i].shouldShowOverEvent == true) {
          return true;
        }
      }
    }
    return false;
  }

  void display() {
    fillShape(shouldShowOverEvent);

    pushMatrix();
    translate(centerX, centerY);
    if (shouldRotate()) {
      rotate(pivotTheta);
    }
    drawShape(0, 0, sizeX, sizeY);
    popMatrix();
  }

  void pressed() {
    isMoving = shouldShowOverEvent;
  }

  void released() {
    isMoving = false;
    xSpring.resetTargetValue();
    ySpring.resetTargetValue();
  }
}
