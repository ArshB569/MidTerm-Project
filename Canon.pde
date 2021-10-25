PImage background, start;
PVector b1, s1;
float gravity = 0.4;
float gravityDelta = 0.01;
float friction = 0.99;
float floor;

Cannon cannon;
ArrayList<Enemy> planes;
ArrayList<Explosion> explosions;
int carInterval = 1000;
int markTime = 0;
boolean debug = true;
color debugColor = color(255, 127, 0);

PImage explosionImg;
PImage pawnImg;
PImage enemyImg;

void setup() {
  size(1200, 630, P2D);
  background = loadImage("back.png");
  //start = loadImage("start.png");
  b1 = new PVector(width/2,height/2);
  //s1 = new PVector(width/2, height/2);
  imageMode(CENTER);
  floor = height;
  
  cannon = new Cannon(width/2, height - 100);
  planes = new ArrayList<Enemy>();
  explosions = new ArrayList<Explosion>();

  pawnImg = loadImage("tank.png");
  pawnImg.resize(220,250);
  
  enemyImg = loadImage("plane.png");
  enemyImg.resize(120,280);
  imageMode(CENTER);

  //explosionImg = loadImage("explosion.png");
  explosionImg = loadImage("fire.png");
  explosionImg.resize(256, 256);
  imageMode(CENTER);
}

void draw() {
  background(127);
  
  noTint();
  //image (start, s1.x, s1.y);
  image (background, b1.x, b1.y);
  text("Press Space to shoot" ,530,35);
  textSize(20);
  
  int t = millis();
  
  if (t > markTime + carInterval) {
    planes.add(new Enemy());
    markTime = t;
  }
    
  cannon.run();
    
  // loop through arrays and clean up "dead" objects
  for (int i=planes.size()-1; i>=0; i--) {
    Enemy plane = planes.get(i);
    
    if (plane.alive) {
      plane.run();
    } else {
      planes.remove(i);
    }
  }
  
  for (int i=explosions.size()-1; i>=0; i--) {
    Explosion explosion = explosions.get(i);
    
    if (explosion.alive) {
      explosion.run();
    } else {
      explosions.remove(i);
    }
  }
  
  println("Number of bullets: " + cannon.bullets.size());
  
  surface.setTitle("" + frameRate);
}

boolean hitDetectRect(PVector p1, PVector p2, PVector hitbox) {
  hitbox = hitbox.copy().div(2);
  
  if (p1.x >= p2.x - hitbox.x && p1.x <= p2.x + hitbox.x && p1.y >= p2.y - hitbox.y && p1.y <= p2.y + hitbox.y) {
    return true;
  } else {
    return false;
  }
}
