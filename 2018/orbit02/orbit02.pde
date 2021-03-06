int seed = int(random(999999));

void setup() {
  size(displayWidth, displayHeight, P3D);
  smooth(4);
  pixelDensity(2);
  generate();
}

void draw() {
  if (frameCount%(60*10) == 0) seed = int(random(999999));
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  float time = millis()*0.001*random(0.8, 4)*0.01;
  float mtime = time%1;

  background(0);

  ortho();
  translate(width*0.5, height*0.5);
  noiseDetail(2);
  scale(1.2+noise(random(1000)+time));
  //rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateX(time*random(-0.1, 0.1));
  rotateY(time*random(-0.1, 0.1));
  rotateZ(time*random(-0.1, 0.1));

  int orbit = int(random(10));
  for (int i = 0; i < orbit; i++) {
    pushMatrix();
    rotateX(time*random(-0.5, 0.5)*random(1));
    rotateY(time*random(-0.5, 0.5)*random(1));
    rotateZ(time*random(-0.5, 0.5)*random(1));
    translate(0, 0, width*(random(0.07, 0.1)+cos(time*random(0.2))*0.02));
    box(random(5));
    popMatrix();
  }

  stroke(255);
  noFill();
  strokeWeight(1);
  float r = width*0.05;
  for (int i = 0; i < 200; i++) {
    float a1 = random(TWO_PI);
    float a2 = acos(random(-1, 1));
    float xx = sin(a1)*sin(a2);
    float yy = sin(a1)*cos(a2);
    float zz = cos(a1);
    point(xx*r, yy*r, zz*r);
  }
  r = width*1.6;
  for (int i = 0; i < 200; i++) {
    float a1 = random(TWO_PI);
    float a2 = acos(random(-1, 1));
    float xx = sin(a1)*sin(a2);
    float yy = sin(a1)*cos(a2);
    float zz = cos(a1);
    point(xx*r, yy*r, zz*r);
  }

  int val = int(time);
  int cc = 50;
  float ss = width*1.4/cc;
  for (int i = 0; i < cc; i++) {
    randomSeed(seed+(i-val)*1000);
    pushMatrix();
    translate(0, 0, (i+mtime)*ss*2);
    float s = ss*random(20);
    if (i < 10) {
      s *= pow(map((mtime+i), 0, 10, 0, 1), 1.2);
    }

    if (i < 4) {
      float mm = pow(map((mtime+i), 0, 4, 0, 1), 1.6);
      stroke(255, 120*(1-mm));
      ellipse(0, 0, s*10, s*10);
    }

    stroke(255);
    if (random(1) < 0.8) {
      float amp = ss*0.5;
      if (i <= 3) amp *= map(i+mtime, 0, 4, 0, 1);
      if (random(1) < 0.5) line(0, 0, -amp, 0, 0, amp); 
      else point(0, 0, 0);
    }


    int rnd = int(random(8));
    if (rnd == 0) ellipse(0, 0, s, s);
    if (rnd == 1) {
      int sub = int(random(3, 33));
      float amp = random(0.1, 0.9);
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        float a2 = ang+(j+amp)*da;
        arc(0, 0, s, s, a1, a2);
      }
    }  
    if (rnd == 2) {
      int sub = int(random(3, 33));
      float amp = random(0.1, 0.9);
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        float a2 = ang+(j+amp)*da;
        arc(0, 0, s, s, a1, a2);
      }
    } 
    if (rnd == 3) {
      int sub = int(random(3, 33));
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      float r1 = s*random(0.5);
      float r2 = s*random(0.5)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        line(cos(a1)*r1, sin(a1)*r1, 0, cos(a1)*r2, sin(a1)*r2, 0);
      }
    } 
    if (rnd == 4) {
      int sub = int(random(3, 33));
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      float r1 = s*random(0.5);
      float amp = ss*random(0.1, 0.9)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        line(cos(a1)*r1, sin(a1)*r1, -amp, cos(a1)*r1, sin(a1)*r1, amp);
      }
    } 
    popMatrix();
  }


  text(frameRate, width*0.06, -2);
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
