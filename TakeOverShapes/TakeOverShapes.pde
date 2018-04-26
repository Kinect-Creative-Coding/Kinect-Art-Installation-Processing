// COLORS
color aqua = color(116, 200, 192);
color pink = color(205, 67, 90);

// SHAPES
int numberOfCircles = 8;
int numberOfRects = 10; 
int numberOfShapes = numberOfCircles + numberOfRects;
SpringyShape[] springs = new SpringyShape[numberOfShapes];

// LIFECYCLE
void setup() {
  size(640, 360);
  noStroke();

  for (int i=0; i<numberOfCircles; i++) {
    springs[i] = new CircleSpring(randomizer.aquaOrPink(), randomizer.randomXPos(), randomizer.randomYPos(), randomizer.circleSize(), springs, i);
  }

  for (int i=numberOfCircles; i<numberOfCircles + numberOfRects; i++) {
    springs[i] = new RectSpring(randomizer.aquaOrPink(), randomizer.randomXPos(), randomizer.randomYPos(), randomizer.orientation(), springs, i);
  }
}

void draw() {
  background(255);

  for (SpringyShape spring : springs) {
    spring.update();
    spring.display();
  }
}

void mousePressed() {
  for (SpringyShape spring : springs) {
    spring.pressed();
  }
}

void mouseReleased() {
  for (SpringyShape spring : springs) {
    spring.released();
  }
}
