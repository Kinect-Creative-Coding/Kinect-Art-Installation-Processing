import processing.core.PApplet;

public class PColor {
//    private PApplet _parent;
    private int _color;

    public PColor(PApplet p, int red, int green, int blue) {
//        this._parent = p;
        _color = p.color(red, green, blue);
    }
}
