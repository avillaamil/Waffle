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
    
    if (scalePosX >= myLimit - scaleW) {  // if the x pos of scale is less than my limit
      scalePosX = 300;
      scalePosY += scaleH;
    } 
    else
    {
      scalePosX += scaleW;
    }
    
    ellipse(scalePosX, scalePosY, scaleW, scaleH);
    //arc(scalePosX, scalePosY, scaleW, scaleH, 0, PI); // make a scale
  }
  
  noLoop();
}

