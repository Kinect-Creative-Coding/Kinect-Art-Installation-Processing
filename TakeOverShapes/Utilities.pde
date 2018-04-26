Randomizer randomizer = new Randomizer();

class Randomizer {
  final float[] ORIENTATIONS = {0.0, HALF_PI, 3.0 / 4.0 * QUARTER_PI, QUARTER_PI};
  float orientation() {
    final int randomIndex = int(random(ORIENTATIONS.length));
    return ORIENTATIONS[randomIndex];
  }
  
  final color[] COLORS = {aqua, pink};
  color aquaOrPink() {
    final int randomIndex = int(random(COLORS.length));
    return COLORS[randomIndex];
  }
  
  final int[] CIRCLE_SIZES = {60, 60, 25, 20, 18};
  color circleSize() {
    final int randomIndex = int(random(CIRCLE_SIZES.length));
    return CIRCLE_SIZES[randomIndex];
  }
  
  final int PADDING = 60;
  float randomXPos() {
    return random(0 + PADDING, width - PADDING); 
  }
  float randomYPos() {
    return random(0 + PADDING, height - PADDING); 
  }
}
