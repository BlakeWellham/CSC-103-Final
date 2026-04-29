//////////////////////////////////////////////////////// Create Arrays for Enemies and Bullets and Create Player Object

ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemys = new ArrayList<Enemy>();

Player p;
Friend f;

PImage[] shootImages;
PImage[] bulletImages;
PImage[] walkImages;
PImage[] enemyImages;
PImage[] friendwalkImages;
PImage[] celebrateImages;
PImage[] playerCelebrateImages;
PImage[] enemyHitImages;
PImage bckground;

Animation shootAnim;
Animation bulletAnim;
Animation walkAnim;
Animation enemyAnim;
Animation friendAnim;
Animation celebrateAnim;
Animation playerCelebrateAnim;
Animation enemyHitAnim;

int lastShotTime = 0;
int shootCooldown = 350;
int maxEnemies = 3;
int totalEnemies = 30;

int state = 0;

int playerHealth = 100;
int enemiesLeft = 30; //needs to be 100 for final
int ammoLeft = 10;

int reloadStartTime = 0;
int reloadDuration = 500;

boolean playedCelebrate = false;
boolean playedAww = false;
boolean isReloading = false;

import processing.sound.*;
SoundFile gun;
SoundFile backgroundmusic;
SoundFile celebrate;
SoundFile aww;
SoundFile tom;
SoundFile reload;

//////////////////////////////////////////////////////// Setup Function

void setup(){
  size(575,575, P2D);
  
  shootImages = new PImage[8];
  bulletImages = new PImage[1];
  walkImages = new PImage[4];
  enemyImages = new PImage[2];
  friendwalkImages = new PImage[4];
  celebrateImages = new PImage[1];
  playerCelebrateImages = new PImage[1];
  enemyHitImages = new PImage[2];
  
  bckground = loadImage("bckground.jpg");

  for (int index = 0; index<= shootImages.length-1; index++){
    shootImages[index] = loadImage("shoot"+index+".png");
  }
  for (int index = 0; index<= bulletImages.length-1; index++){
    bulletImages[index] = loadImage("bullet"+index+".png");
  }
  for (int index = 0; index<= walkImages.length-1; index++){
    walkImages[index] = loadImage("walk"+index+".png");
  }
  for (int index = 0; index<= enemyImages.length-1; index++){
    enemyImages[index] = loadImage("enemy"+index+".png");
  }
  for (int index = 0; index<= friendwalkImages.length-1; index++){
    friendwalkImages[index] = loadImage("friendwalk"+index+".png");
  }
  for (int index = 0; index<= celebrateImages.length-1; index++){
    celebrateImages[index] = loadImage("celebrate"+index+".png");
  }
  for (int index = 0; index<= playerCelebrateImages.length-1; index++){
    playerCelebrateImages[index] = loadImage("playerCelebrate"+index+".png");
  }
  for (int index = 0; index<= enemyHitImages.length-1; index++){
    enemyHitImages[index] = loadImage("enemyHit"+index+".png");
  }

  shootAnim = new Animation(shootImages, .75,.15,false);
  bulletAnim = new Animation(bulletImages, .05,.15,false);
  walkAnim = new Animation(walkImages, .10,0.15,true);
  friendAnim = new Animation(friendwalkImages,0.10,0.15,true);
  celebrateAnim = new Animation(celebrateImages,0.10,0.15,true);
  playerCelebrateAnim = new Animation(playerCelebrateImages,0.10,0.15,true);
  
  p = new Player(100, height/2, 50, 5,
  walkAnim, shootAnim,playerCelebrateAnim);
  
  f = new Friend(500,p.y,50,5,friendAnim,celebrateAnim);
  
  gun = new SoundFile(this,"gun.mp3");
  backgroundmusic = new SoundFile(this,"backgroundmusic.mp3");
  celebrate = new SoundFile(this,"celebrate.mp3");
  aww = new SoundFile(this,"aww.mp3");
  tom = new SoundFile(this,"tom.mp3");
  reload = new SoundFile(this,"reload.mp3");
  
  backgroundmusic.play();
  backgroundmusic.loop();
}

void draw(){  
  imageMode(CORNER);
  image(bckground,0,0);
  
  
  switch(state){
    case 0:
      startScreen();
      break;
    case 1:
      playGame();
      break;
    case 2:
      winScreen();
      break;
    case 3:
      lossScreen();
      break;
    case 4:
      resetGame();
      break;
  }
}

void mousePressed(){
  if(isReloading) return;
  
  if(millis() - lastShotTime >= shootCooldown && ammoLeft > 0){
    p.shoot();
    gun.play();
    bullets.add(new Bullet(p.x+35,p.y-15,3,color(0,0,0),15));
    lastShotTime = millis();
    ammoLeft = ammoLeft -1;
  }
}

void startScreen(){
  textAlign(CENTER,CENTER);
  fill(color(175,175,175));
  textSize(25);
  text("Shoot the Enemies! Save you Friend!", width/2, height/2);
  textSize(15);
  text("Press Spacebar to Start",width/2,height/2 + 100);
  if(keyPressed){
    if(key == ' '){
      state = 1;
    }
  }
}

void UIBar(){
  rectMode(CORNER);
  fill(color(175,175,175));
  rect(0,500,width,100);
  textSize(25);
  fill(color(0,0,0));
  text(playerHealth,50,525);
  text(ammoLeft, width/2, 525);
  text(enemiesLeft,525,525);
  textSize(10);
  text("Health",50,510);
  text("Bullets Left",width/2,510);
  text("Enemies Remaining",525,510);
}

void reloadText(){
  textAlign(CENTER,CENTER);
  textSize(25);
  fill(color(255,0,0));
  text("Press R to Reload!",width/2,height/2);
  if(keyPressed && key == 'r' && !isReloading){
      reloadStartTime = millis();
      reload.play();
      isReloading = true;
  }
}

void winScreen(){
    textAlign(CENTER,CENTER);
    fill(color(0,255,0));
    textSize(25);
    text("You Win!",width/2,height/2);
    textSize(15);
    text("Press Spacebar to Play Again!",width/2,height/2+100);
    if(keyPressed){
      if(key == ' '){
        state = 4;
      }
    }
    f.render();
    f.move();
    p.render();
    playerCelebrateAnim.isAnimating = true;
    if(!playedCelebrate){
    celebrate.play();
    playedCelebrate = true;
    }
    if(backgroundmusic.isPlaying()){
      backgroundmusic.pause();
    }
  }

void lossScreen(){
    textAlign(CENTER,CENTER);
    fill(color(255,0,0));
    textSize(25);
    text("You Lose!",width/2,height/2);
    textSize(15);
    text("Press Spacebar to Play Again!",width/2,height/2+100);
    if(!playedAww){
      aww.play();
      playedAww = true;
      }
    if(backgroundmusic.isPlaying()){
      backgroundmusic.pause();
      }
    if(keyPressed){
      if(key == ' '){
        state = 4;
      }
    }
  }


void resetGame(){
  playerHealth = 100;
  ammoLeft = 10;
  enemiesLeft = 30;
  state = 1;
  celebrate.pause();
  playedCelebrate = false;
  playedAww = false;
  aww.pause();
  playerCelebrateAnim.isAnimating = false;
  if(!backgroundmusic.isPlaying()){
    backgroundmusic.play();
    backgroundmusic.loop();
  }
  p.x = 100;
  p.y = height/2;
  f.x = 500;
}

void playGame(){
    UIBar();
    
    if(enemiesLeft <= 0){
      state = 2;
    }
    
    if(ammoLeft <= 0){
      reloadText();
    }
    
    if(playerHealth <= 0){
      state = 3;
    }
    
    if(isReloading){
      if(millis() - reloadStartTime >= reloadDuration){
        ammoLeft = 10;
        isReloading = false;
      }
    }  
    
    if(enemys.size()<maxEnemies){
      enemys.add(new Enemy(width, random(50,height-50), 50, color(0,0,255),5,
      new Animation(enemyImages,0.05,2.5,true),
      new Animation(enemyHitImages,0.10,2.5,true)));
    }

    p.render();
    p.move();
  
    for(int i = bullets.size()-1; i >= 0; i--){
      Bullet b = bullets.get(i);
      
        b.render();
        b.move();
      
        for (int j = enemys.size()-1; j >= 0; j--){
          Enemy e = enemys.get(j);
      
          if(b.collisionDetection(e)){
            bullets.remove(i);
            enemiesLeft = enemiesLeft - 1;
            
            e.currentAnim = e.enemyHitAnim;
            e.currentAnim.isAnimating = true;
            e.dying = true;
            e.deathStartTime = millis();
            break;
          }        
        }
      }
        
    for(int i = enemys.size()-1; i >= 0; i--){
    Enemy e = enemys.get(i);
   
      if(e.dying){
        e.render();
        if(millis()-e.deathStartTime > 200){
           enemys.remove(i);
        }
        continue;
      }
       
      e.chase();
      e.render();
    
      if(e.collisionDetection(p)){
        enemys.remove(i);
        playerHealth = playerHealth - 10;
        tom.rate(1.25);
        tom.play();
        enemiesLeft = enemiesLeft - 1;
        }
      }
    }
