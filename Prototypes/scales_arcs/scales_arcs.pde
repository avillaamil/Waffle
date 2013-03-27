int scalePosX =300;
int scalePosY;
int numScale = 35;
int scaleW = 20;
int scaleH = 40;

void setup() {
  size(1000, 1500);
  smooth();
  background(230);
  stroke(1);
}


void draw() {

  line(width/2, 0, width/2, height);

  ellipseMode(CORNER); // HAS TO BE CENTER, BECAUSE I'M USING ELLIPSES ELSEWHERE
  fill(130);
 
  float myLimit = width/2; // set limit

  for (int i=0; i<numScale; i++) {
    
    //int scalePosX = i*scaleW+300;   // sets first scale at x=300 and prevents overlap
    scalePosX += scaleW;

    if (scalePosX < myLimit) {  // if the x pos of scale is less than my limit
      arc(scalePosX, scalePosY, scaleW, scaleH, 0, PI); // make a scale
    } 
    else {
      //scalePosX = 300;
      arc(scalePosX, scalePosY+scaleH-20, scaleW, scaleH, 0, PI); // start lower
    }
  }
}

