class Player extends Entity{
  
  Vector projDir;
  float projSpeed;
  PhysicsEngine engine;
  int maxProj;
  int projs;
  
  public Player( Vector pos ){
    super();
    attack = 1;
    hp = 20;
    projDir = calculateProjDir();
    projSpeed = 5; 
    this.pos = pos;
    engine = null;
    maxProj = 5;
    projs = 0;
  }
  
  public void setCollisionRadius(){
    this.collider.radius = 10.5;
  }
  
  public Vector getColliderCenter(){
    return this.pos.cpy();
  }
  
  public void fire(){
    this.projs = engine.countProjs();
    if(this.projs < maxProj ){
      engine.addEntity(new Projectile(this));
      this.projs++;
      //println(this.projs);
    }
  }
  
  public void die(){
    this.alive = false;
    engine.player = null;
    //println("BLAAAH");
  }
  
  public void hit( Entity e ){
    if( e instanceof Enemy ){
      this.hp -= e.attack;
      engine.hitCounter = 13;
    }
    if( hp <= 0){
      die();
    }
    this.collider.endCollision();
  }
  
  public boolean isXInbounds( Vector v1 ){
    if( v1.x < 0 || v1.x > height){
     return false;
    }
    return true;
  }
  
  public boolean isYInbounds( Vector v1 ){
    if( v1.y < 0 || v1.y > width){
     return false;
    }
    return true;
  }
  
  public void updatePosition( float t ){
    Vector aux = this.pos.cpy();
    aux.add(this.vel.staticScalarMult(t));
    if( isXInbounds( aux ) ){
      this.pos.x = aux.x;
    }
    if( isYInbounds( aux ) ){
      this.pos.y = aux.y;
    }
  }
  
  public void decreaseProjs(){
    if(projs > 0 )
      this.projs--;
  }
  
  public Vector calculateProjDir(){
    Vector dir = new Vector( mouseX - this.pos.x , mouseY - this.pos.y);
    return dir;
  }
  
}

//--------Projectile-------//

class Projectile extends Entity{
  
  Player p;
  
  public Projectile( Player p ){
    super();
    attack = p.attack;
    pos = p.pos.cpy();
    vel = p.calculateProjDir();
    this.p = p;
    vel.normalize(p.projSpeed);
  }
  
  public void setCollisionRadius(){
    this.collider.radius = 6;
  }
  
  public void die(){
    this.alive = false;
    p.decreaseProjs();
  }
  
  public void hit( Entity e ){
    if( e instanceof Enemy ){
      die();
    }
    this.collider.endCollision();
  }
  
  public Vector getColliderCenter(){
    return this.pos.cpy();
  }
  
  public void boundControl(){
    die();
  }
}