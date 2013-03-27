PVector temp1;
PVector temp2;
PVector temp3;

void setup(){
  size(1280, 800);
  background(255); 
  smooth();
  noFill();
}

void draw(){

  translate(width/2, height/2);

  int radius = 300;                                      // size
  float numPoints = 100;                                // points for vertices later
  float pointDegree = 366 / numPoints;                 // makes a (full) circle
  float noiseCount = 0;                               // set it later for randomness!
  
 // Adding the PVectors in an array
  ArrayList<PVector> shapePoints = new ArrayList();
  for (int i=0; i<numPoints; i++) {
    float x = cos(radians(pointDegree * i)) * radius;
    float y = sin(radians(pointDegree * i)) * radius;
    float n = noise(noiseCount) * 20;
    PVector temp = new PVector(x+n, y+n);
    noiseCount += 0.2;                        // degree of randomness
    shapePoints.add(temp);
  }
  
  
    //TRIANGLES
//  stroke(255);
//  strokeWeight(1);
//  fill(100, 255, 30, 10);
//  for (int i = 0; i < 50; i++){
//    temp1 = shapePoints.get(int(random(0, shapePoints.size())));
//    temp2 = shapePoints.get(int(random(0, shapePoints.size())));
//    temp3 = shapePoints.get(int(random(0, shapePoints.size())));
//    triangle(temp1.x, temp1.y, temp2.x, temp2.y, temp3.x, temp3.y);
//}
  
  //OUTERSHAPE
  stroke(100);
  strokeWeight(4);
  beginShape();
  for (int i = 0; i < numPoints; i++){
    PVector thisvector = shapePoints.get(i);
    vertex(thisvector.x, thisvector.y);
    noiseCount += 20;
  }
  endShape();
  
  save("circle.png");



}
