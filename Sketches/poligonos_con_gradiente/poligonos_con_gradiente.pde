int sides=3;
boolean changes;

class Point {
  float x;
  float y;
  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

void setup() {
  size(500, 500, P2D);
  strokeWeight(1);
  colorMode(HSB, 360, 100, 100, 100);
  // "Hue, Saturation, Brightness" colour mode (instead of RBG)
  background(0, 0, 90);
  frameRate(25);
  changes = true;
}

void drawPolygon(int sides) {
  float r = width/2.2;
  int i;
  Point[] p = new Point[sides];
  float t=0;

  color from = color(0, 0, 100);
  color to = color(0, 75, 100);
  color inter = lerpColor(from, to, .33);
  float paso = 0;
  float radio_inicio = 0;

  for (float d = 0; d < r; d += 0.25) {
    t=0;
    for (i = 0; i < sides; i++) {
      p[i] = new Point(d*cos(t), d*sin(t));
      t += TWO_PI/sides;
    }
    translate(width/2, height/2);
    rotate(PI);
    //scale(10);

    if (d > radio_inicio) {
      paso = map(d, radio_inicio, r, 0, 1);
      stroke(lerpColor(from, to, paso));
    }
    else {
      stroke(0, 0, 100);
    }

    line(p[0].x, p[0].y, p[sides-1].x, p[sides-1].y);
    for (int j = 0; j < (sides - 1); j++) {
      line(p[j].x, p[j].y, p[j+1].x, p[j+1].y);
    }
  }
  translate(0,0);
}

void draw() {
  if (changes) {
    background(0, 0, 90);
    drawPolygon(sides);
    saveFrame("poligono_con_gradiente.png");
    changes = false;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    sides++;
    changes = true;
  } 
  else if (mouseButton == RIGHT) {
    if (sides > 3) sides--;
    changes = true;
  }
}

