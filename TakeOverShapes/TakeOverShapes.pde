// COLORS
color aqua = color(116, 200, 192);
color pink = color(205, 67, 90);

// SHAPES
int numberOfCircles = 18;
int numberOfRects = 9; 
int numberOfSquares = 4;
SpringyShape[] springs = new SpringyShape[numberOfCircles + numberOfRects + numberOfSquares];

// GRID
GridMaker gridMaker;

// LIFECYCLE
void setup() {
  size(640, 360);
  noStroke();

  // (int maxWidth, int maxHeight, int numRows, int numColumns, int padding, int randomizeBy)
  gridMaker = new GridMaker(width, height, 5, 6, 40, 40);

  int currentNumberOfShapes = 0;

  for (int i=0; i<numberOfCircles; i++) {
    springs[i] = new CircleSpring(randomizer.aquaOrPink(), 
      gridMaker.getCurrentX(), gridMaker.getCurrentY(), 
      //randomizer.randomXPos(), randomizer.randomYPos(), 
      randomizer.circleSize(), springs, i);

    gridMaker.iterateNext();
  }
  currentNumberOfShapes += numberOfCircles;

  for (int i=currentNumberOfShapes; i<currentNumberOfShapes + numberOfRects; i++) {
    springs[i] = new RectSpring(randomizer.aquaOrPink(), 
      int(random(20, 150)), 15, 
      gridMaker.getCurrentX(), gridMaker.getCurrentY(), 
      //randomizer.randomXPos(), randomizer.randomYPos(), 
      randomizer.orientation(), springs, i);

    gridMaker.iterateNext();
  }
  currentNumberOfShapes += numberOfRects;

  for (int i=currentNumberOfShapes; i<currentNumberOfShapes + numberOfSquares; i++) {
    int size = int(random(15, 20));
    springs[i] = new RectSpring(pink, 
      size, size, 
      gridMaker.getCurrentX(), gridMaker.getCurrentY(), 
      //randomizer.randomXPos(), randomizer.randomYPos(), 
      randomizer.orientation(), springs, i);

    gridMaker.iterateNext();
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
