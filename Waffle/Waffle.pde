/*  ~~~ Waffle Prototype ~~~
     ~~ Second Iteration ~~
   
  Alessandra Villaamil
  ITP Thesis 2013
 
 */

import geomerative.*;
import controlP5.*;
ControlP5 cp5;

RPolygon ellipsePolygon;
float noiseCount = 0;

/* Initializing CP5 Controllers
 ---------------------------------------------------------------- */
 int bkgCol = 220;
 int waffleSize = 200;
 int segmentLength = 20;

/* Setup
 ---------------------------------------------------------------- */
void setup() {
  size(1000, 800); 
  //frameRate(10);
  addControllers();
  smooth();


//BIRTHING AN RPOLYGON
  RG.init(this);
  // make an RShape with an ellipse
  RShape ellipze = RShape.createEllipse(width/2, height/2, waffleSize, waffleSize);   
  RCommand.setSegmentLength(segmentLength);
  //RCommand.setSegmentator(RCommand.UNIFORMLENGTH); // ??
  ellipsePolygon = ellipze.toPolygon();    // turn the RShape into an RPolygon

// THIS BREAKS PROCESSING
//  for (int i=0; i < width; i++){
//    for(int j=0; j < height; j++){
//      RPoint p = new RPoint(i, l);
//      if (ellipsePolygon.contains(p)){
//        pushMatrix();
//        translate(i, j);
//        ellipse(i, j, 5, 5);
//        popMatrix();
//      }
//    }
//  }

}



/* Draw
 ---------------------------------------------------------------- */
void draw() {
  background(bkgCol);
  
  beginShape();
  
  noStroke();
  fill(100, 80);
  
  for(int i = 0; i < ellipsePolygon.contours[0].points.length; i++) {
    RPoint curPoint = ellipsePolygon.contours[0].points[i];
    float noiseVal = noise(noiseCount + i) * 20;
    curveVertex(curPoint.x + noiseVal, curPoint.y + noiseVal);
  }
  
  noiseCount += 0.01;
  
  endShape();
}




/* AddControllers
 ---------------------------------------------------------------- */
void addControllers() {
  //noStroke();
  cp5 = new ControlP5(this);

  //SLIDERS
  cp5.addSlider("bkgCol", 0, 255).linebreak();
  cp5.addSlider("waffleSize", 100, 500).linebreak();
  cp5.addSlider("segmentLength", 5, 200).linebreak();
  
  // BUTTONS
  cp5.addButton("saveImage").linebreak();
}



/* SaveImage
 ---------------------------------------------------------------- */
void saveImage(int theValue ) {
  println("Saving high quality image");
  save("waffle2_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved");
}

void keyPressed() {
  if (key == 's') saveImage(0);
}

