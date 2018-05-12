import processing.core.*;
//import SimpleOpenNI.*; // kinect
//import blobDetection.*; // blobs
//import toxi.geom.*; // toxiclibs shapes and vectors
//import toxi.processing.*; // toxiclibs display
//import shiffman.box2d.*; // shiffman's jbox2d helper library
//import org.jbox2d.collision.shapes.*; // jbox2d
//import org.jbox2d.dynamics.joints.*;
//import org.jbox2d.common.*; // jbox2d
//import org.jbox2d.dynamics.*; // jbox2d

public class MyProcessingSketch extends PApplet {
	
	public static void main(String[] args) {
		PApplet.main(new String[] {"MyProcessingSketch"});
	}
	
	//	An array of stripes
	Stripe[] stripes = new Stripe[50];

	public void settings() {
		size(200,200);

	}

	public void setup() {
		// Initialize all "stripes"
		for (int i = 0; i < stripes.length; i++) {
			stripes[i] = new Stripe(this);
		}
	}

	public void draw() {
		background(100);
		// Move and display all "stripes"
		for (int i = 0; i < stripes.length; i++) {
			stripes[i].move();
			stripes[i].display();
		}
	}
}
//
//public class Color extends int.class  {
//}
