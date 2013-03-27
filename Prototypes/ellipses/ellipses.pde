import controlP5.*;
ControlP5 cp5;

int shiftR = 1;

void setup() {
  size(1500, 500);
  background(220);
  smooth();
  noFill();
  
  addControllers();
  
}


void draw() {
  background(220);
  strokeWeight(1);
  ellipse(width/2, height/2, 200, 200);
  
  strokeWeight(1);
  noFill();
  for (int i=0; i<shiftR; i++){
   // int shiftR = circleshifter;
  int w = width/2;
  int h = height/2;
  
  //stroke(0);
  //ellipse(w+i*2, h, 200, 200);
  
  
  stroke(0, 200, 100);
  ellipse(w+i*10, h, 200, 200);
  //stroke(0, 100, 200);
  //ellipse(w-i*10, h, 200, 200);
  }  
 
  
  
}

void addControllers(){
 cp5 = new ControlP5(this);

  cp5.addSlider("shiftR", 1, 100).linebreak(); 
}

void saveImage(int theValue ) {
  println("Saving high quality image");
  save("waffle_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".png");
  println("Saved");
}

void keyPressed() {
  if (key == 's') saveImage(0);
}
