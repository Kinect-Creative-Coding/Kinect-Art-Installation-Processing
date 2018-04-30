// How to add new shapes:
// Look for "SHAPE STEP" in this class. There are 3 steps.
// Also add a shape to 'SpringyShapes_Custom'

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
  gridMaker = new GridMaker(width, height, numRows, numColumns, 60, 20);

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
  SPRINGYRECT, SPRINGYSQUARE, SPRINGYCIRCLE, SPRINGYTRIANGLE, SPRINGYLESSTHAN, SPRINGYLETTERE; 

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
    case SPRINGYTRIANGLE:
      //float triangleSize = mainClass.random(1, 2);
      return mainClass.new TriangleSpring(randomizer.pink, 
        30, 40, 
        //int(triangleSize * 20.0), int(triangleSize * 30.0), 
        xPos, yPos, 
        randomizer.orientation(), mainClass.springs, id);
    case SPRINGYLESSTHAN:
      return mainClass.new LessThanSpring(randomizer.aquaOrPink(), 
        45, 87, 
        xPos, yPos, 
        randomizer.orientation(), mainClass.springs, id);
    case SPRINGYLETTERE:
      return mainClass.new LetterESpring(randomizer.aquaOrPink(), 
        47, 60, 
        xPos, yPos, 
        randomizer.orientation(), mainClass.springs, id);
    default:
      println("TakeOverShapes ERROR: Did not specify shapeForType for " + this);
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
      return 10;
    case SPRINGYTRIANGLE:
      return 3;
    case SPRINGYLESSTHAN:
      return 2;
    case SPRINGYLETTERE:
      return 2;
    default:
      println("TakeOverShapes ERROR: Did not specify weight for " + this);
      return 0;
    }
  }
}
