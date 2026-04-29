//////////////////////////////////////////////////////// Create Player Class

class Player{
  float x, y, d;
  float pTop, pBottom, pLeft, pRight;
  float speed;
  
  Animation walkAnim;
  Animation shootAnim;
  Animation currentAnim;
  Animation playerCelebrateAnim;
  
  Player(float startingX, float startingY, float startingD, float startingSpeed,
   Animation walkAnimation, Animation shootAnimation, Animation playerCelebrateAnimation){
    x = startingX;
    y = startingY;
    d = startingD;
    speed = startingSpeed;
    
    walkAnim = walkAnimation;
    shootAnim = shootAnimation;
    playerCelebrateAnim = playerCelebrateAnimation;
    currentAnim = walkAnim;
    
    walkAnim.isAnimating = true;
    
  }
  
//////////////////////////////////////////////////////// Render Player Class

  void render(){
    imageMode(CENTER);
    currentAnim.display(x,y);
    
    if(!shootAnim.isAnimating){
      currentAnim = walkAnim;
    }
    if(playerCelebrateAnim.isAnimating){
      currentAnim = playerCelebrateAnim;
    }
  }

//////////////////////////////////////////////////////// Moves Player Up and Down but Constrains Player to the Window

  void move(){
    if(y + d/2 >= 0 && y - d/2 <= height){
    if(keyPressed){
      if(key == 'w') y -= speed;
      if(key == 's') y += speed;
        }
      }
    y = constrain(y,45,455);
    
    pLeft = x - d/2;
    pRight = x + d/2;
    pTop = y - d/2;
    pBottom = y + d/2;
    }
    
  void shoot(){
    shootAnim.isAnimating = true;
    shootAnim.index = 0;
    currentAnim = shootAnim;
    }
  }
