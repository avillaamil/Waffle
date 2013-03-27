void setup() {
  size(800, 1000);
  background(100);

  strokeWeight(1);
  translate(0, height/4);
  float noiseCount = 0;
  noiseDetail(1);

  for (int i=1; i<5; i++) {
    stroke(255, 30);
    beginShape();
    translate(0, height/8);

    for (int j=0; j<width+40; j++) {
      float ranY = noise(noiseCount);
      vertex(j, ranY*height/3);
      strokeWeight(width/150);
      line(j, ranY*height/3, j, height);
      noiseCount += 0.12;
      strokeWeight(width/50);
    }
    endShape();
  }
}

