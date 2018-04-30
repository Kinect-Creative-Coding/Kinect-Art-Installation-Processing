class TriangleSpring extends SpringyShape {
  TriangleSpring(color fillColor, int triangleLength, int triangleWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, triangleLength, triangleWidth, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float shapeWidth, float shapeHeight) {
    triangle(-shapeWidth/2, -shapeHeight/2, // Top left
      shapeWidth/2, -shapeHeight/2, // Top right
      0, shapeHeight/2); // Bottom center
  }
}

class RectSpring extends SpringyShape {
  RectSpring(color fillColor, int rectLength, int rectWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, rectLength, rectWidth, 0.98, random(15, 25), 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float shapeWidth, float shapeHeight) {
    rect(-shapeWidth/2, -shapeHeight/2, shapeWidth, shapeHeight);
  }
}

class CircleSpring extends SpringyShape {
  CircleSpring(color fillColor, float x, float y, int radius, SpringyShape[] springs, int id) {
    super(x, y, radius, radius, 0.98, random(15, 25), 0.1, 0, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float shapeWidth, float shapeHeight) {
    ellipse(0, 0, shapeWidth, shapeHeight);
  }

  boolean shouldRotate() {
    return false;
  }
}
