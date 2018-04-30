class GridMaker {
  private int numRows;
  private int numColumns;
  private int padding;
  private int randomizeBy;

  private int widthPerColumn;
  private int heightPerRow;

  private int currentIndex = 0;

  GridMaker(int maxWidth, int maxHeight, int numRows, int numColumns, int padding, int randomizeBy) {
    this.numRows = numRows;
    this.numColumns = numColumns;
    this.padding = padding;
    this.randomizeBy = randomizeBy;
    
    widthPerColumn = (maxWidth - 2 * padding) / (numColumns - 1);
    heightPerRow = (maxHeight - 2 * padding) / (numRows - 1);
  }

  void reset() {
    currentIndex = 0;
  }

  void iterateNext() {
     int totalIndicies = numRows * numColumns;
    currentIndex = (currentIndex + 1) % totalIndicies;
  }

  int getCurrentX() {
    return padding + getCurrentColumn() * widthPerColumn + int(random(-randomizeBy, randomizeBy));
  }

  int getCurrentY() {
    return padding + getCurrentRow() * heightPerRow + int(random(-randomizeBy, randomizeBy));
  }
  
  private int getCurrentRow() {
    return currentIndex / numColumns;
  }
  
  private int getCurrentColumn() {
    return currentIndex % numColumns;
  }
}
