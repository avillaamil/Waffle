/*  ~~~ Waffle Prototype ~~~
 
 Alessandra Villaamil
 ITP Thesis 2013
 
 */

import controlP5.*;
ControlP5 cp5;

//INITIALIZING CP5 CONTROLS
int bkgCol = 220;                              // gray bkg
int waffleSize = 200;                         // size of circle
int waffleColor;                             // grayscale circle
int strokeSize = 0;                         // grayscale stroke
int strokeColor = 255;                     // points around the circle
int wafflePoints = 100;                   // noise amt for circle
float waffleNoise = 20;                  // noise
int wafflePointDegree = 900;            // makes it a full circle
int iwaffle = 11;                      // cone levels
int scales = 0;                       // number of scales
int shiftR = 0;                      // circle shifter


color[] allColors = new color [8];
int ran;


ArrayList<PVector> points = new ArrayList<PVector>();
int radius = waffleSize;
float numPoints = wafflePoints;
float pointDegree = wafflePointDegree / numPoints;
float noiseCount;

ArrayList<PVector> particles = new ArrayList();
int numParticles;
float particleMaxRadius;

// scales
int numScale = 20;
int scaleW = 20;
int scaleH = 40;

//GHOSTAGENCY
//float noiseScale = 0.2;
//float noiseCount = 1;
//int myLimit = width;



/* Setup
 ---------------------------------------------------------------- */
void setup() {
  size(1000, 800);
  frameRate(10);
  addControllers();

  //recursion(width/2, height/2, 700);

  allColors[0] = color(#FF3999);                 // pink 
  allColors[1] = color(#FFF41A);                // yellow 
  allColors[2] = color(#55BFD8);               // teal 
  allColors[3] = color(#491086);              // purple 
  allColors[4] = color(#5EF552);             // green 
  allColors[5] = color(#FF381A);            // red-orange 
  allColors[6] = color(#1F1E1E);           // dark grey 
  allColors[7] = color(#E3E3E3);          // light grey

  // adding particle points to arraylist
  particles.add( new PVector(200, 200));
  particles.add( new PVector(400, 300)); 
  float particleMaxRadius = 150;
  int numParticles = 400;
}

/* Draw
 ---------------------------------------------------------------- */
void draw() {
  background(bkgCol);

  // @&%$@#&^*++++ Just a circle
  //  fill(allColors[(int)random(0,7)]);
  //  stroke(strokeColor);
  //  strokeWeight(strokeSize);
  //  ellipse(width/2, height/2, waffleSize, waffleSize);


  // @&%$@#&^*++++ Circle with points and angles 
    pushMatrix();
    translate(width/2, height/2);
    for (int i = 0; i < wafflePoints; i++) {
      float x = cos(radians(pointDegree * i)) * radius;
      float y = sin(radians(pointDegree * i)) * radius;
      float n = noise(noiseCount) * waffleNoise;
      points.add(new PVector(x + n, y + n));
      noiseCount += 0.2;
    }
  
    for (int i = 0; i < 500; i++) {
      strokeWeight(strokeSize);
      stroke(strokeColor);
  
      //fill(int(random(50, 255)), 0, 0, 30);    //red color
      fill(allColors[int(random(0, 7))], 200);   //looping through colors array
      PVector loc1 = points.get( int(random(0, points.size())) );
      PVector loc2 = points.get( int(random(0, points.size())) );
      PVector loc3 = points.get( int(random(0, points.size())) );
      triangle(loc1.x, loc1.y, loc2.x, loc2.y, loc3.x, loc3.y);
    }
    popMatrix();

  // @&%$@#&^*++++ Sarah's cone
  //    stroke(strokeSize);
  //    fill(allColors[(int)random(0, 7)], 30);
  //    //fill(0, 1);
  //    for (int i=0; i<iwaffle; i=i+10) {
  //      ellipse(width/2, i+30, i, i);
  //   }

  // @&%$@#&^*++++ Sarah's outwards
  //    stroke(strokeSize);
  //    fill(allColors[(int)random(0, 7)], 80);
  //    //fill(0, 1);
  //    ran = int(random(1, 150)); // makes circles wider randomly
  //    for (int i=0; i<iwaffle; i=i+ran) {
  //     ellipse(width/2, height/2, i+30, i+30);
  //    }

  // @&%$@#&^*++++ Scales, yo!!
  //ellipseMode(CORNER);
  fill(#FFF41A);
  stroke(0);
  for (int i=0; i<scales; i++) {
    arc(i*scaleW+200, 55, scaleW, scaleH, 0, PI);
  }

  // @&%$@#&^*++++ Mini particle system
  for (int i = 0; i < particles.size(); i++) {    // loop through all the particles
    // get the point
    PVector p = particles.get(i);

    // draw numParticles particles around point
    for (int j = 0; j < numParticles; j++) {
      float radius = particleMaxRadius - (sin(radians((j % 90))) * particleMaxRadius);
      float rot = random(360);
      float x = cos(radians(rot)) * radius;
      float y = sin(radians(rot)) * radius;
      ellipse(p.x + x, p.y + y, 5, 5);
    }
  }

  // @&%$@#&^*++++ Circle shifter
//  strokeWeight(2);
//  noFill();
//  int w = width/2;
//  int h = height/2;
//  stroke(0, 250, 150, 80);  // green
//  for (int j=0; j<shiftR; j++) {
//    ellipse(w, h, 200+j*8, 200+j*8);
//  }
//
//  strokeWeight(1);
//  for (int i=0; i<shiftR; i++) {
//
//
//    if (i<60) {
//      // faint strokes
//      stroke(#FF3999, 80);  // pink
//      ellipse(w+i*4, h, 200, 200+i);
//      stroke(#FFF41A, 80);  // yellow
//      ellipse(w-i*4, h, 200, 200+i);
//    } 
//    else {
//      stroke(#FF3999, 80);  // pink
//      ellipse(w+i*4, h, 200, 200+i);
//      stroke(#FFF41A, 80);  // yellow
//      ellipse(w-i*4, h, 200, 200+i);
//    }
//
//    //stroke(200, 120, 0);
//    //ellipse(w+i*10, h, 200, 200);
//    //stroke(0, 100, 200);
//    //ellipse(w-i*10, h, 200, 200);
//  }
}


/* AddControllers
 ---------------------------------------------------------------- */
void addControllers() {
  //noStroke();
  cp5 = new ControlP5(this);

  //SLIDERS
  cp5.addSlider("bkgCol", 0, 255).linebreak();
  cp5.addSlider("waffleSize", 5, 500).linebreak();
  cp5.addSlider("waffleColor", 0, 255).linebreak();
  cp5.addSlider("strokeSize", 0, 100).linebreak();
  cp5.addSlider("strokeColor", 0, 255).linebreak();
  cp5.addSlider("waffleNoise", 20, 200).linebreak();
  cp5.addSlider("wafflePointDegree", 100, 900).linebreak();
  cp5.addSlider("wafflePoints", 10, 500).linebreak();
  cp5.addSlider("iwaffle", 11, 500).linebreak();
  cp5.addSlider("scales", 0, 20).linebreak();
  cp5.addSlider("shiftR", 1, 100).linebreak();

  // BUTTONS
  //cp5.addButton("randomize").linebreak();
  cp5.addButton("saveImage").linebreak();
}

/* OTHER FUNCTIONS
 ---------------------------------------------------------------- */
void recursion(int x, int y, int siz) {
  pushMatrix();
  translate(x, y);
  fill(0, random(100), random(100));
  ellipse(0, 0, siz, siz);
  popMatrix();

  if (siz > 10) {
    recursion(x, y, siz - round(random(20)));
  }
}

// SAVING THE IMAGE
void saveImage(int theValue ) {
  println("Saving high quality image");
  save("waffle_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved");
}

void keyPressed() {
  if (key == 's') saveImage(0);
}

