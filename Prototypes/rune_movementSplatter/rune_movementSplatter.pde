import geomerative.*;

RPolygon ellipsePolygon;

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
  beginShape();
  
  for(int i = 0; i < ellipsePolygon.contours[0].points.length; i++)
  {
    RPoint curPoint = ellipsePolygon.contours[0].points[i];
    curPoint.x = curPoint.x + random(1, 10);
    curPoint.y = curPoint.y + random(1, 10);
    curveVertex(curPoint.x, curPoint.y);
  }
  
  endShape();
}
