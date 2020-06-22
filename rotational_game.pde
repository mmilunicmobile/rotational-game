Player myPlayer;

boolean W, A, S, D;

void setup() {
  myPlayer = new Player(0, 0, 1);
  size(500,400, P2D);
}

void draw() {
  background(255);
  myPlayer.move();
  myPlayer.display();
}

class Player {
  float xvel, yvel;
  float xpos, ypos;
  float speed;
  
  Player(float tempxpos, float tempypos, float tempxspeed) {
    xpos = tempxpos;
    ypos = tempypos;
    xvel = 0;
    yvel = 0;
    speed = tempxspeed;
  }
  
  void display() {
    ellipseMode(CENTER);
    fill(0, 200, 250);
    ellipse(xpos, ypos, 30, 30);
  }
  
  void move() {
    if (W == true) yvel = -10;
    if (A == true) xvel -= speed;
    if (D == true) xvel += speed;
    
    yvel += 0.5;
    
    xpos += xvel;
    ypos += yvel;
    
    xvel *= .85;
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') W = true;
  if (key == 'a' || key == 'A') A = true;
  if (key == 's' || key == 'S') S = true;
  if (key == 'd' || key == 'D') D = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') W = false;
  if (key == 'a' || key == 'A') A = false;
  if (key == 's' || key == 'S') S = false;
  if (key == 'd' || key == 'D') D = false;
}

float yOf2PointsWithX(float xPoint1, float yPoint1, float xPoint2, float yPoint2, float x) {
  return (((yPoint2 - yPoint1)/(xPoint2 - xPoint1))*(x - xPoint1)+yPoint1);
}

boolean collision(float[] hitbox1, float[] hitbox2) {
}
