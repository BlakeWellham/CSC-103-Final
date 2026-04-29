class Animation{
  PImage[] images;
  float speed, scale, index;
  boolean isAnimating;
  boolean loop;
  
  Animation(PImage[] tempImages, float tempSpeed, float tempScale,
  boolean shouldLoop){
    speed = tempSpeed;
    scale = tempScale;
    loop = shouldLoop;
    
    index = 0;
    isAnimating = false;
    
    images = new PImage[tempImages.length];
    for(int i = 0; i< tempImages.length; i++){
      images[i] = tempImages[i].copy();
      images[i].resize(int(tempImages[i].width*scale),int(tempImages[i].height*scale));
    }
  }
  
  void next(){
    index += speed;
    
    if(index >= images.length){
      if (loop){
      index = 0;
      } else {
        index = images.length - 1;
        isAnimating = false;
      }
    }
  }
  
  void display(float px, float py){
    PImage img = images[int(index)];
    image(img,px,py);
    next();
  }
}
