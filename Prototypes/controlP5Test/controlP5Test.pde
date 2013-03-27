import controlP5.*;

ControlP5 cp5;

void setup() {
  size(1000, 800);
  addControllers();
  
  randomize();
  drawScreen();
}

void draw(){
  // loops for ControlP5
}


public void addControllers(){
  cp5 = new ControlP5(this);
  cp5.addSlider("centerRad", 5, 125).linebreak();
  cp5.addSlider("strokeInside", minStroke, maxStroke).linebreak();
  cp5.addSlider("strokeCenter", minStroke, maxStroke).linebreak();
  cp5.addSlider("strokeOutside", minStroke, maxStroke).linebreak();
  cp5.addSlider("separation", minSep, maxSep).linebreak();
  cp5.addSlider("globalScale", 0.0, 3.0).linebreak();
  cp5.addSlider("backgroundScale", 0.0, 20.0).linebreak();
  cp5.addSlider("cap", 1, 3).linebreak();
  cp5.addButton("randomize").linebreak();
  cp5.addButton("saveTest").linebreak();
  cp5.addButton("saveImage").linebreak();
}

void strokeInside(int val){
  strokes[0] = val;
}
void strokeCenter(int val){
  strokes[1] = val;
}
void strokeOutside(int val){
  strokes[2] = val;
}

public void controlEvent(ControlEvent theEvent) {
  drawScreen();
}

void saveTest(int theValue ) {
  println("Saving test image");
  //canvas.save("image_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved");
}

void saveImage(int theValue ) {
  println("Saving high quality image");
  //canvas.save("image_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".tiff");
  println("Saved");
}

void keyPressed(){
  if (key == 's') saveImage(0);
}

/* Design
 ---------------------------------------------------------------- */
// [letters] [circles] [segments]  from inside to outside
float[][][] letters = {
  {{0, 0}, {40, 320}, {40, 320}},                       // C
  {{0, 0}, {0, 360}, {0, 360}},                         // O  
  {{0,225}, {10, 45, 190, 225}, {130, 225, 310, 405}},  // N
  {{140, 220}, {140, 220}, {60, 140, 220, 300}},        // E
  {{70,110}, {70,110}, {220, 320}},                     // T
  {{270, 450}, {270, 420}, {35,60}},                    // R
  {{0, 360}, {0, 0}, {255, 285, 75, 105}},              // I   
};

float backgroundScale = 5.0;
float globalScale = 1.0;
int minStroke = 15;
int maxStroke = 75;
int minSep = 0;
int maxSep = 75;
int cap = 2;
int separation = 30;
int centerRad = 50;
int[] strokes = {
  60, 60, 60, 120
};

// updates screen when called
void drawScreen() {
  background(100);
  drawCanvas();
  //float resizedWidth = (float) canvas.width * ratio;
  //float resizedHeight = (float) canvas.height * ratio;
  //image(canvas, (width / 2) - (resizedWidth / 2), (height / 2) - (resizedHeight / 2), resizedWidth, resizedHeight);
}

// updates canvas
void drawCanvas() {
  //beginDraw();
  background(255);
  noStroke();
  noFill();
  smooth();
  stroke(0);
  ellipseMode(RADIUS);
  if( cap == 1 ) strokeCap(ROUND);
  else if( cap == 2 ) strokeCap(SQUARE);
  else if( cap == 3 ) strokeCap(PROJECT);
  
  // circle background representation
  if(backgroundScale > 0.0 ) drawBackground(width/2, height/2);

  // word
  drawLetter( 0, width*0.20, height*0.25 );  // C
  drawLetter( 1, width*0.50, height*0.25 );  // O
  drawLetter( 2, width*0.80, height*0.25 );  // N
  drawLetter( 0, width*0.20, height*0.5 );   // C
  drawLetter( 3, width*0.50, height*0.5 );   // E
  drawLetter( 2, width*0.80, height*0.5 );   // N
  drawLetter( 4, width*0.20, height*0.75 );  // T
  drawLetter( 5, width*0.40, height*0.75 );  // R
  drawLetter( 6, width*0.60, height*0.75 );  // I
  drawLetter( 0, width*0.80, height*0.75 );  // C
  
 // canvas.endDraw();
}

// randomizes typeface parameters
void randomize() {
  strokes[0] = (int)random(minStroke,maxStroke);
  strokes[1] = (int)random(minStroke,maxStroke);
  strokes[2] = (int)random(minStroke,maxStroke);
  separation = (int)random(minSep, maxSep);
  centerRad = (int)random(5, 125);
  
  cp5.getController("strokeInside").setValue(strokes[0]);
  cp5.getController("strokeCenter").setValue(strokes[1]);
  cp5.getController("strokeOutside").setValue(strokes[2]);
  cp5.getController("separation").setValue(separation);
  cp5.getController("centerRad").setValue(centerRad);

}

// draws one letter in one position
void drawLetter( int i, float x, float y ) {
  float rad = centerRad+strokes[0]/2; 
  
  pushMatrix();
  translate(x, y);
  scale(globalScale);
  
  // access every circle
  for (int j=0; j<letters[i].length; j++ ) {
    strokeWeight( strokes[j] );
    
    // access every arc (pair of numbers) inside that circle
    for( int k=0; k<letters[i][j].length/2; k++ ){
      if ( letters[i][j][k] + letters[i][j][k+1] != 0 ) {
        stroke(0, 250);
        arc(0, 0, rad, rad, radians(letters[i][j][k*2]), radians(letters[i][j][k*2+1]));
      }
    }
    rad += strokes[j]/2 + strokes[j+1]/2 + separation;
  }
  popMatrix();
}

// draws base circles (can be used for general background or for indidivual letters)
void drawBackground(float x, float y){
    pushMatrix();
    translate(x, y);
    scale(backgroundScale);
    
    float rad = centerRad+strokes[0]/2; 
    for( int k=0; k<3; k++ ){
          strokeWeight( strokes[k] );
          stroke(0, 7);
          arc(0, 0, rad, rad, 0, 2*PI);
          rad += strokes[k]/2 + strokes[k+1]/2 + separation;
    }
    popMatrix();
}
