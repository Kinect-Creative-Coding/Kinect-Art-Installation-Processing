// How to add new shapes
// Look for "SHAPE STEP" in this class. There are 3 steps.

// GRID
GridMaker gridMaker;
int numRows = 5;
int numColumns = 7;

// All the Springy Shapes
SpringyShape[] springs = new SpringyShape[numRows * numColumns];

// Tools to randomize colors and positions
Randomizer randomizer = new Randomizer();

// LIFECYCLE
void setup() {
  size(640, 360);
  noStroke();

  // (int maxWidth, int maxHeight, int numRows, int numColumns, int padding, int randomizeBy)
  gridMaker = new GridMaker(width, height, numRows, numColumns, 60, 40);

  SpringyShapeRandomizer shapeRandomizer = new SpringyShapeRandomizer();

  for (int i=0; i<(numRows * numColumns); i++) {
    // int(randomizer.randomXPos()), int(randomizer.randomYPos())
    SpringyShape newRandomShape =  shapeRandomizer.randomShape(int(gridMaker.getCurrentX()), int(gridMaker.getCurrentY()), i, this);
    springs[i] = newRandomShape;
    gridMaker.iterateNext();
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

// Create new shapes and assign weight here
enum SpringyShapeType {
  
  // CREATE SHAPE STEP 1
  SPRINGYRECT, SPRINGYSQUARE, SPRINGYCIRCLE; 

  // CREATE SHAPE STEP 2
  SpringyShape shapeForType(int xPos, int yPos, int id, TakeOverShapes mainClass) {    
    Randomizer randomizer = mainClass.randomizer;

    switch (this) {
    case SPRINGYRECT:
      return mainClass.new RectSpring(randomizer.aquaOrPink(), 
        int(randomizer.randomFloat(20, 150)), 15, 
        xPos, yPos, 
        randomizer.orientation(), mainClass.springs, id);
    case SPRINGYSQUARE:
      int size = int(randomizer.randomFloat(15, 20));
      return mainClass.new RectSpring(randomizer.pink, 
        size, size, 
        xPos, yPos, 
        randomizer.orientation(), mainClass.springs, id);
    case SPRINGYCIRCLE:
      return mainClass.new CircleSpring(randomizer.aquaOrPink(), 
        xPos, yPos, 
        randomizer.circleSize(), mainClass.springs, id);
    default:
      return null;
    }
  }

  float percentage() {
    return float(weight()) / float(totalWeight());
  }

  static int totalWeight() {
    int total = 0;
    for (SpringyShapeType type : SpringyShapeType.values()) {
      total += type.weight();
    }
    return total;
  }

  // CREATE SHAPE STEP 3
  private int weight() {
    switch (this) {
    case SPRINGYRECT:
      return 2;
    case SPRINGYSQUARE:
      return 1;
    case SPRINGYCIRCLE:
      return 8;
    default:
      return 0;
    }
  }
}
