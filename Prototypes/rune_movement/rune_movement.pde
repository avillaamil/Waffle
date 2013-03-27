import geomerative.*;

RPolygon ellipsePolygon;
float noiseCount = 0;

void setup() 
{
  size(1280, 800); 
  smooth();
  fill(83, 142, 35);
  noStroke();

  RG.init(this);
  
  // make an RShape with an ellipse
  RShape ellipze = RShape.createEllipse(200, 500, 200, 200);
  //ellipze.draw();
  
  RCommand.setSegmentLength(20);
  //RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  // turn the RShape into an RPolygon
  ellipsePolygon = ellipze.toPolygon();

  
 
  
  
}

void draw()
{
  background(255);
  beginShape();
  
  for(int i = 0; i < ellipsePolygon.contours[0].points.length; i++)
  {
    RPoint curPoint = ellipsePolygon.contours[0].points[i];
    float noiseVal = noise(noiseCount + i) * 20;
    curveVertex(curPoint.x + noiseVal, curPoint.y + noiseVal);
  }
  
  noiseCount += 0.01;
  
  endShape();
}
