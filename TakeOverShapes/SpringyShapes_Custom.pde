class RectSpring extends SpringyShape {
  color aColor;

  RectSpring(color aColor, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, int(random(20, 150)), 15, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.aColor = aColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    rect(x - shapeWidth/2, y - shapeHeight/2, shapeWidth, shapeHeight);
  }

  void fillShape(boolean hasMouseOver) {
    if (hasMouseOver) {
      fill(153);
    } else {
      fill(aColor);
    }
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

  void fillShape(boolean hasMouseOver) {
    if (hasMouseOver) {
      fill(153);
    } else {
      fill(aColor);
    }
  }

  boolean shouldRotate() {
    return false;
  }
}
