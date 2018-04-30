class TriangleSpring extends SpringyShape {
  TriangleSpring(color fillColor, int triangleLength, int triangleWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, triangleLength, triangleWidth, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    triangle(x, y, x + shapeWidth, y, x + shapeWidth / 2, y + shapeHeight);     
  }
}

class RectSpring extends SpringyShape {
  RectSpring(color fillColor, int rectLength, int rectWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, rectLength, rectWidth, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    rect(x - shapeWidth/2, y - shapeHeight/2, shapeWidth, shapeHeight);
  }
}

class CircleSpring extends SpringyShape {
  CircleSpring(color fillColor, float x, float y, int radius, SpringyShape[] springs, int id) {
    super(x, y, radius, radius, 0.98, random(15, 25), 0.1, 0, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float x, float y, float shapeWidth, float shapeHeight) {
    ellipse(x, y, shapeWidth, shapeHeight);
  }

  boolean shouldRotate() {
    return false;
  }
}
