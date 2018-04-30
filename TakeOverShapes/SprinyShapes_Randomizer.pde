class SpringyShapeRandomizer {
    
  SpringyShape randomShape(int xPos, int yPos, int id, TakeOverShapes mainClass) {
    return randomShapeType().shapeForType(xPos, yPos, id, mainClass);
  }

  private SpringyShapeType randomShapeType() {
    float randomIndex = random(SpringyShapeType.totalWeight());

    for (SpringyShapeType type : SpringyShapeType.values()) {
      if  (randomIndex <= type.weight()) {
        return type;
      }
      randomIndex -= type.weight();
    }

    return SpringyShapeType.SPRINGYRECT;
  }
}
