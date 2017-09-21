abstract class Entity{
  Vector pos;
  Vector vel;
  Vector acc;
  
  float maxVel;
  
  int hp;
  int attack;
  boolean alive;
  
  Collider collider;
  
  public Entity(){
    pos = new Vector(0,0);
    vel = new Vector(0,0);
    acc = new Vector(0,0);
    attack = 1;
    hp = 1;
    alive = true;
    maxVel = 3;
    collider = new Collider(this,1);
    setCollisionRadius();
  }
  
  public abstract void die();
  public abstract void hit( Entity e );
  public abstract void setCollisionRadius();
  public abstract Vector getColliderCenter();
  
  public void stop(){
    this.acc = new Vector(0,0);
    this.vel = new Vector(0,0);
  }
  
  public void update( float t ){
    updateVelocity(t);
    updatePosition(t);
  }
  
  public void updateVelocity( float t ){
    this.vel.add( this.acc.staticScalarMult(t) );
    if( vel.modulo() > maxVel ){
      vel.normalize();
      vel.scalarMult(maxVel);
    }
  }
  
  public void updatePosition( float t ){
    Vector aux = this.pos.cpy();
    aux.add( this.vel.staticScalarMult(t) );
    if( isOutOfBounds(aux) ){
      pos = aux.cpy();
      boundControl();
    }else{
      pos = aux.cpy();
    }
  }
  
  public boolean isXOutOfBounds(Vector v1){
    if( v1.x < 0 || v1.x > height ){
      return true;
    }
    return false;
  }
  
  public boolean isYOutOfBounds(Vector v1){
    if( v1.y < 0 || v1.y > width ){
      return true;
    }
    return false;
  }
  
  public boolean isOutOfBounds( Vector v1){
    if( isXOutOfBounds(v1) || isYOutOfBounds(v1) ){
      return true;
    }
    return false;
  }
  
  public void boundControl(){};
}