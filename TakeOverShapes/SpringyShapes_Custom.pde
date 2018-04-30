class TriangleSpring extends SpringyShape {
  TriangleSpring(color fillColor, int triangleLength, int triangleWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, triangleLength, triangleWidth, 0.98, random(10, 15), 0.1, theta, springs, id);
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

// The "<" sign <
class LessThanSpring extends SpringyShape {
  LessThanSpring(color fillColor, int shapeLength, int shapeWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, shapeLength, shapeWidth, 0.98, random(25, 35), 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float shapeWidth, float shapeHeight) {    
    beginShape();
    vertex(0, 0);
    vertex(shapeWidth/2, shapeHeight/2);
    vertex(0, shapeHeight/2);
    vertex(-shapeWidth/2, 0);
    vertex(0, -shapeHeight/2);
    vertex(shapeWidth/2, -shapeHeight/2);
    endShape(CLOSE);
  }
}

// The "E" sign <
class LetterESpring extends SpringyShape {
  LetterESpring(color fillColor, int shapeLength, int shapeWidth, float x, float y, float theta, SpringyShape[] springs, int id) {
    super(x, y, shapeLength, shapeWidth, 0.98, 35, 0.1, theta, springs, id);
    this.fillColor = fillColor;
  }

  void drawShape(float w, float h) {
    float gap = h / 10.0; // Vertical gap between arms in the E
    float armHeight = (h - gap * 2.0) / 3.0; // Height of each of the 3 arms in the E
    float spineWidth = w * 0.45; // Horizontal width of the spine of the E
    
    beginShape();
    
    // Top line of the E
    vertex(-w/2, -h/2);
    vertex(w/2, -h/2);
    
    // Underside of the top arm of the E
    vertex(w/2, -h/2 + armHeight);
    vertex(-w/2 + spineWidth, -h/2 + armHeight);

    // Topside of the middle arm of the E
    vertex(-w/2 + spineWidth, -armHeight/2);
    vertex(w/2, -armHeight/2);
    
    // Bottomside of the middle arm of the E
    vertex(w/2, armHeight/2);
    vertex(-w/2 + spineWidth, armHeight/2);

    // Top of the bottom arm of the E
    vertex(-w/2 + spineWidth, h/2 - armHeight);
    vertex(w/2, h/2 - armHeight);
    
    // Bottom line of the E
    vertex(w/2, h/2);
    vertex(-w/2, h/2);
    endShape(CLOSE);
  }
}
