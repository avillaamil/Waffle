//Kim Ash
//Printing Code
//martian - creates generative book cover for Ray Bradbury's Martian Chronicles

import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 7650;

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;



void setup()
{ 
  size(510, 765);
  colorMode(HSB, 1, 1, 1);
  canvas = createGraphics(canvas_width, canvas_height);
  calculateResizeRatio();
  
  
  canvas.beginDraw();
    canvas.colorMode(HSB, 1, 1, 1);
    TColor col = TColor.newHSV(.04, .98, .98);
    ColorTheoryStrategy rcomp = new RightSplitComplementaryStrategy();
    ColorList rcompList = ColorList.createUsingStrategy(rcomp, col);
    TColor back = rcompList.get(3);
    canvas.background(back.hue(), back.saturation(), back.brightness());
    canvas.smooth();
    canvas.noFill();
    //canvas.strokeCap(PROJECT);
    
  
    //mountains
    ColorTheoryStrategy s = new AnalogousStrategy();
    ColorList colors = ColorList.createUsingStrategy(s, col);
    
    canvas.pushMatrix();
    canvas.strokeWeight(canvas.width/50);  //150
    canvas.translate(0, canvas.height/4);
    float noiseCount = 0;
    noiseDetail(1);
    for(int m=1; m<5; m++)
    {
      TColor c = colors.get(m);
      canvas.stroke(c.hue(), c.saturation(), c.brightness());
      canvas.beginShape();
      canvas.translate(0, canvas.height/8);
      for(int i=0; i<canvas.width + 40; i+=100)
      {
        float ranY = noise(noiseCount);
        canvas.vertex(i, ranY*canvas.height/3);
        canvas.strokeWeight(canvas.width/150);
        canvas.line(i, ranY*canvas.height/3, i, canvas.height);
        noiseCount += 0.12;
        canvas.strokeWeight(canvas.width/50);
      }
      canvas.endShape();
    } 
    canvas.popMatrix();
    
  
  canvas.endDraw();
  
  float resizedWidth = (float) canvas.width * ratio;
  float resizedHeight = (float) canvas.height * ratio;
  //displays canvas onscreen
  image(canvas, (width/2) - (resizedWidth/2), (height/2) - (resizedHeight/2), resizedWidth, resizedHeight);
  
 // canvas.save("martian.tiff");
}


/* resizing function */
void calculateResizeRatio()
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;
  
  if(ratioWidth < ratioHeight)  ratio = ratioWidth;
  else                          ratio = ratioHeight;
}

//grid
void grid(float pageMargin)
{
  //bounding box for manuscript grid
  canvas.noFill();
  canvas.stroke(0.4, 1, 1,0);  //change alpha value to see gridlines
  canvas.strokeWeight(canvas.width/300);
  canvas.rect(pageMargin, pageMargin, canvas.width - (2*pageMargin), canvas.height - (2*pageMargin));
  canvas.line(5.6*canvas.width/15, pageMargin, 5.6*canvas.width/15, canvas.height-(pageMargin));
  //canvas.line(canvas.width-2*pageMargin, pageMargin, canvas.width-2*pageMargin, canvas.height-pageMargin);
  canvas.line(pageMargin, 4.5*canvas.height/15, canvas.width-pageMargin, 4.5*canvas.height/15);
}


