
class Friend{
  float x, y, d;
  float speed;
  
  Animation friendAnim;
  Animation celebrateAnim;
  Animation currentAnim;
    
  Friend(float startingX, float startingY, float startingD, float startingSpeed,
   Animation friendAnimation, Animation celebrateAnimation){
    x = startingX;
    y = startingY;
    d = startingD;
    speed = startingSpeed;
    
    friendAnim = friendAnimation;
    celebrateAnim = celebrateAnimation;
    currentAnim = friendAnim;
    
    friendAnimation.isAnimating = true;
    
  }

  void render(){
    imageMode(CENTER);
    currentAnim.display(x,p.y);
    
    if(!friendAnim.isAnimating){
      currentAnim = celebrateAnim;
      celebrateAnim.isAnimating = true;
      currentAnim.index = 0;
    }
  }

  void move(){
    if(x >= 150){
    x-= speed;
    } else {
      
      x = 150;
      speed = 0;
      currentAnim = celebrateAnim;
    }
  }
}
