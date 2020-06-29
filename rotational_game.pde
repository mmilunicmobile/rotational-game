//creating variables
Player myPlayer;

boolean W, A, S, D;



void setup() {
  //initialization
  myPlayer = new Player(0, 0, 1);
  
  //creating screen
  size(500,400, P2D);
}



void draw() {
  background(255);
  
  //player functions
  myPlayer.move();
  myPlayer.display();
}



//actually the player class
class Player {
  //variables
  float xvel, yvel;
  float xpos, ypos;
  float speed;
  
  //constructor
  Player(float tempxpos, float tempypos, float tempxspeed) {
    xpos = tempxpos;
    ypos = tempypos;
    xvel = 0;
    yvel = 0;
    speed = tempxspeed;
  }
  
  //displaying functionality
  void display() {
    ellipseMode(CENTER);
    fill(0, 200, 250);
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
