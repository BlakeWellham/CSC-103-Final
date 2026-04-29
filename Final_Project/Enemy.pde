//////////////////////////////////////////////////////// Create Enemy Class

class Enemy{
  float x, y, d;
  float eTop, eBottom, eLeft, eRight;
  int color1;
  float speed; 
  float dx, dy;
  boolean dying = false;
  int deathStartTime = 0;
  
  Animation enemyAnim;
  Animation enemyHitAnim;
  Animation currentAnim;
  
  Enemy(float startingX, float startingY, float startingD,
  int startingColor1, float startingSpeed,
  Animation enemyAnimation, Animation enemyHitAnimation){
    x = startingX;
    y = startingY;
    d = startingD;
    color1 = startingColor1;
    speed = startingSpeed;
 
    enemyAnim = enemyAnimation;
    enemyHitAnim = enemyHitAnimation;
    currentAnim = enemyAnim;
    
    currentAnim.isAnimating = true;
  }
  
//////////////////////////////////////////////////////// Render Enemy

  void render(){
    currentAnim.display(x,y);
    }

//////////////////////////////////////////////////////// Detect Collisions with Player Object

  boolean collisionDetection(Player p){
    if(eTop <= p.pBottom &&
    eBottom >= p.pTop &&
    eLeft <= p.pRight &&
    eRight >= p.pLeft){
      return true;
    }
    return false;
  }

//////////////////////////////////////////////////////// Chase Player

  void chase(){   
    dx = p.x - x;
    dy = p.y - y;
    
    float mag = sqrt(dx*dx + dy*dy);
    dx /= mag;
    dy /= mag;
    
    x += dx * speed;
    y += dy * speed;
    
    eLeft = x - d/2;
    eRight = x + d/2;
    eBottom = y + d/2;
    eTop = y - d/2;
  }
}
