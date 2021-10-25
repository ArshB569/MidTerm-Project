class Cannon {

  PVector position;
  float rot = 0;
  float rotDelta = 2;
  ArrayList<Bullet> bullets;
  
  Cannon(float x, float y) {
    position = new PVector(600, 600);
    bullets = new ArrayList<Bullet>();
  }
  
  void update() {
    rot += rotDelta;    
    if (rot < -60 || rot > 60) rotDelta *= -1;  
    
    for (int i=bullets.size()-1; i>=0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.alive) {
        bullet.run();
      } else {
        bullets.remove(i);
      }
    }
  }
  
  void fire() {
    bullets.add(new Bullet(position.x, position.y, rot));
  }
  
  void draw() {
    pushMatrix(); 
    translate(position.x, position.y);
    rotate(radians(rot));
    image(pawnImg, 0, 0 );
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }

}
