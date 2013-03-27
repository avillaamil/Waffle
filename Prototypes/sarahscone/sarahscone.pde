void setup() { 
  size(1000, 1800);
  background(255);
  smooth();
}


void draw() {
  stroke(0);
  strokeWeight(1);
  fill(0, 1);

  for (int i=0; i<500; i=i+10) {
    //ellipse(width/2, height/2, 10, 10);
    ellipse(width/2, i+100, i, i);
    //triangle(-500,175, 2980, 175, 1240, 4008);
    //fill(0,0.0001);
    //rect(-1,-1,2481,3509);
  }
}

