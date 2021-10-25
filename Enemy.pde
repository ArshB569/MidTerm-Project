class Enemy {
  
  boolean isLeft;
  PVector position, target;
  float movementSpeed = 0.01;
  float xMargin = 700;
  float yMargin = 150;
  boolean alive = true;
  PVector enemySize = new PVector(150, 60);

  Enemy() {
    float pickSide = random(1);
    float y = random(yMargin, height-yMargin*2);
    float x1, x2;
    //if (pickSide < 0.5) {
      isLeft = true;
      x1 = -xMargin;
      x2 = width + xMargin;
    position = new PVector(x1, y);  
    target = new PVector(x2, y);  
  }
  
  void update() {
    if (position.dist(target) < 5) alive = false;
    
    for (Bullet bullet : cannon.bullets) {
      if (alive && hitDetectRect(position, bullet.position, enemySize)) {
        alive = false;
        explosions.add(new Explosion(position.x, position.y));
      }
    }
    
    if (alive) position.lerp(target, movementSpeed);
  }
  
  void draw() {
    
    image(enemyImg, position.x, position.y, enemySize.x, enemySize.y);
    rectMode(CENTER);
    
    if (debug) {
      fill(debugColor);
      stroke(debugColor);
    }
  }
  
  void run() {
    update();
    draw();
  }
    
}
