// COLORS
color aqua = color(116, 200, 192);
color pink = color(205, 67, 90);

// SHAPES
int numberOfCircles = 10;
int numberOfRects = 8; 
int numberOfSquares = 5;
SpringyShape[] springs = new SpringyShape[numberOfCircles + numberOfRects + numberOfSquares];

// LIFECYCLE
void setup() {
  size(640, 360);
  noStroke();

  int currentNumberOfShapes = 0;
  for (int i=0; i<numberOfCircles; i++) {
    springs[i] = new CircleSpring(randomizer.aquaOrPink(), randomizer.randomXPos(), randomizer.randomYPos(), randomizer.circleSize(), springs, i);
  }
  currentNumberOfShapes += numberOfCircles;
  
  for (int i=currentNumberOfShapes; i<currentNumberOfShapes + numberOfRects; i++) {
    springs[i] = new RectSpring(randomizer.aquaOrPink(), randomizer.randomXPos(), randomizer.randomYPos(), randomizer.orientation(), springs, i);
  }
  currentNumberOfShapes += numberOfRects;

  for (int i=currentNumberOfShapes; i<currentNumberOfShapes + numberOfSquares; i++) {
    springs[i] = new RectSpring(randomizer.aquaOrPink(), randomizer.randomXPos(), randomizer.randomYPos(), randomizer.orientation(), springs, i);
  }
  currentNumberOfShapes += numberOfSquares;

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
