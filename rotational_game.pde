//creating variables
Player myPlayer;
Block myBlock;

boolean W, A, S, D;



void setup() {
  //initialization
  myPlayer = new Player(0, 0, 1);
  myBlock = new Block(width/2 - 15, height/2 - 15, width/2 + 15, height/2 - 15, width/2 + 15, height/2 + 15, width/2 - 15, height/2 + 15);
  
  //creating screen
  size(500,400, P2D);
}



void draw() {
  background(255);
  
  //player functions
  myPlayer.move();
  myPlayer.display();
  
  myBlock.display();
}



//actually the player class
class Player {
  //variables
  float xvel, yvel;
  float xpos, ypos;
  float speed;
  float[] hitbox = new float[8];
  
  //constructor
  Player(float tempxpos, float tempypos, float tempxspeed) {
    xpos = tempxpos;
    ypos = tempypos;
    xvel = 0;
    yvel = 0;
    speed = tempxspeed;
    
    hitbox[0] = xpos - 15;
    hitbox[1] = ypos - 15;
    hitbox[2] = xpos + 15;
    hitbox[3] = ypos - 15;
    hitbox[4] = xpos + 15;
    hitbox[5] = ypos + 15;
    hitbox[6] = xpos - 15;
    hitbox[7] = ypos + 15;
  }
  
  //displaying functionality
  void display() {
    ellipseMode(CENTER);
    fill(0, 200, 250);
    stroke(0);
    strokeWeight(2);
    ellipse(xpos, ypos, 30, 30);
  }
  
  //motion functionality (decides physics)
  void move() {
    if (W == true) yvel = -10;
    if (A == true) xvel -= speed;
    if (D == true) xvel += speed;
    
    yvel += 0.5;
    xpos += xvel;
    ypos += yvel;
    xvel *= .85;
    
    hitbox[0] = xpos - 15;
    hitbox[1] = ypos - 15;
    hitbox[2] = xpos + 15;
    hitbox[3] = ypos - 15;
    hitbox[4] = xpos + 15;
    hitbox[5] = ypos + 15;
    hitbox[6] = xpos - 15;
    hitbox[7] = ypos + 15;
  }
}


class Block {
  //variables
  float[] hitbox = new float[8];
  
  Block(float URx, float URy, float LRx, float LRy, float LLx, float LLy, float ULx, float ULy) {
    hitbox[0] = URx;
    hitbox[1] = URy;
    hitbox[2] = LRx;
    hitbox[3] = LRy;
    hitbox[4] = LLx;
    hitbox[5] = LLy;
    hitbox[6] = ULx;
    hitbox[7] = ULy;
  }
  
  void display() {
    fill(0);
    stroke(0);
    strokeWeight(2);
    quad(hitbox[0], hitbox[1], hitbox[2], hitbox[3], hitbox[4], hitbox[5], hitbox[6], hitbox[7]);
  }
  
  void location(float URx, float URy, float LRx, float LRy, float LLx, float LLy, float ULx, float ULy) {
    hitbox[0] = URx;
    hitbox[1] = URy;
    hitbox[2] = LRx;
    hitbox[3] = LRy;
    hitbox[4] = LLx;
    hitbox[5] = LLy;
    hitbox[6] = ULx;
    hitbox[7] = ULy;
  }
}



//key press detection setup
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



//a mouth that can use hitboxes
boolean hitboxDetection(float[] hitbox1, float[] hitbox2) {
  return rectIntersect(hitbox1[0], hitbox1[1], hitbox1[2], hitbox1[3], hitbox1[4], hitbox1[5], hitbox1[6], hitbox1[7], hitbox2[0], hitbox2[1], hitbox2[2], hitbox2[3], hitbox2[4], hitbox2[5], hitbox2[6], hitbox2[7]);
}



//rectangle intersection detection
/* The rectIntersect requires the x coordinate and y coordinate of all four points in a rectangle for both rectangles.
returns true for they are intercecting and false if not*/
boolean rectIntersect(float AURx, float AURy, float ALRx, float ALRy, float ALLx, float ALLy, float AULx, float AULy, float BURx, float BURy, float BLRx, float BLRy, float BLLx, float BLLy, float BULx, float BULy) {
  float[] axisx = new float[4];
  float[] axisy = new float[4];
  boolean toReturn = true;
  
  axisx[0] = AURx - AULx;
  axisy[0] = AURy - AULy;
  axisx[1] = AURx - ALRx;
  axisy[1] = AURy - ALRy;
  axisx[2] = BULx - BLLx;
  axisy[2] = BULy - BLLy;
  axisx[3] = BULx - BURx;
  axisy[3] = BULy - BURy;
  
  
  for(int i = 0; i <= 3; i++) {
    float[] dotProdA = new float[4];
    float[] dotProdB = new float[4];
    float adf;
    
    adf = (AURx * axisx[i] + AURy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdA[0] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (ALRx * axisx[i] + ALRy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdA[1] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (ALLx * axisx[i] + ALLy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdA[2] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (AULx * axisx[i] + AULy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdA[3] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (BURx * axisx[i] + BURy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdB[0] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (BLRx * axisx[i] + BLRy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdB[1] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (BLLx * axisx[i] + BLLy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdB[2] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    adf = (BULx * axisx[i] + BULy * axisy[i]) / (pow(axisx[i], 2) + pow(axisy[i], 2));
    dotProdB[3] = adf * pow(axisx[i], 2) + adf * pow(axisy[i], 2);
    
    if(!(min(dotProdB) <= max(dotProdA) && min(dotProdA) <= max(dotProdB))) {
      toReturn = false;
    }
  }
  return toReturn;
}
