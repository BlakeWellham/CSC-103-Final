//////////////////////////////////////////////////////// Create Bullet Class

class Bullet{
  float x, y, w;
  float rTop, rBottom, rLeft, rRight;
  int color1;
  float speed;
  float dx, dy;
  Animation bulletAnim;
  
  Bullet(float startingX, float startingY, float startingW,
  int startingColor1, float startingSpeed){
    x = startingX;
    y = startingY;
    w = startingW;
    color1 = startingColor1;
    speed = startingSpeed;
    bulletAnim = new Animation(bulletImages, 0.5, .15,false);
    bulletAnim.isAnimating = true;
    
    // Get Bullets to move towards where the cursor was when 
    // it was clicked instead of just moving them forward.
    // I had AI help me with this part as well as the enemy chase function.
    float targetX = mouseX;
    float targetY = mouseY;
    
    float dirX = targetX - x;
    float dirY = targetY - y;
    
    float mag = sqrt(dirX*dirX + dirY*dirY);
      dx = (dirX/mag) * speed;
      dy = (dirY/mag) * speed;
  }
  
//////////////////////////////////////////////////////// Render Bullet Class

  void render(){
    imageMode(CENTER);
    bulletAnim.display(x+10,y+17);
  }

//////////////////////////////////////////////////////// Move Bullets toward Cursor and Update Bullet Hitboxes

  void move(){  
    x += dx;
    y += dy;
    
    rTop = y - w/2;
    rBottom = y + w/2;
    rLeft = x - w/2;
    rRight = x + w/2;
  }
  
//////////////////////////////////////////////////////// Detect Collisions with Enemy Class

  boolean collisionDetection(Enemy e){
    if(rTop <= e.eBottom &&
    rBottom >= e.eTop &&
    rLeft <= e.eRight &&
    rRight >= e.eLeft){
      return true;
    } 
    return false;
  }
}
  
