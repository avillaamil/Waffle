ArrayList<PVector> points = new ArrayList();

int numParticles;
float particleMaxRadius; 

void setup() {
  size(500, 500);
  fill(255);
  
  // add points to arraylist
  points.add( new PVector(200, 200));
  //points.add( new PVector(400, 300)); 
  
  particleMaxRadius = 150;
  numParticles = 400;
  println("setup is working");
}

void draw() {
  //background(255);
  // loop through all the points
  
  for(int i = 0; i < points.size(); i++) {
    // get the point
    PVector p = points.get(i);
    //println(points.size());
    //delay(50000);
    println("I am after pause");
   
    // draw numParticles particles around point
    for(int j = 0; j < numParticles; j++) {
      println("entering j");
      float radius = particleMaxRadius - (sin(radians((j % 90))) * particleMaxRadius);
      float rot = random(360);
      float x = cos(radians(rot)) * radius;
      float y = sin(radians(rot)) * radius;
      ellipse(p.x + x, p.y + y, 5, 5); 
      println("getting to the second loop");
    }
  }
  
  noLoop();
}



