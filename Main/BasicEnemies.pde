class Enemy extends Entity{
  
  int score;
  float speed;
  
  public Enemy( Vector pos ){
    super();
    this.pos = new Vector(pos.x,pos.y);
    hp = 1;
    attack = 2;
    score = 1;
    speed = 1;
  }
  
  public void die(){
    this.alive = false;
  }
  
  public void update(float t, Player p){
    if( p != null ){ 
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
    }else{
      this.stop();
    }
    super.update(t);
  }
  
  public void hit( Entity e ){
    if( !(e instanceof Enemy) ){
      if( e instanceof Player){
        hp = 0;
      }else{
        hp -= e.attack;
      }
    }
    if( hp <= 0 ){
      die();
    }
    this.collider.endCollision();
  } 
  
  public void setCollisionRadius(){
    this.collider.radius = 10.5;
  }
  
  public Vector getColliderCenter(){
    return this.pos.cpy();
  }
  
}

//---------------Movimiento sinuoso---------------//

class EnemySin extends Enemy{
  
  float rot;
  float amp;
  float frec;
  boolean up;
  
  public EnemySin( Vector pos ){
    super(pos);
    this.rot = 45;//45
    this.up = false;
    this.speed = 1.8;//1.8
    this.amp = 45;//45
    this.frec = 2;//2
    this.attack = 1;
  }
  
  public void update(float t, Player p){
    if( rot > amp || rot < -amp){
      this.up = !this.up;
    }
    if( p != null ){ 
      Vector aux = p.pos.staticSub(this.pos);
      aux.normalize();
      aux.rotate(rot);
      this.vel = aux;
      this.vel.normalize(speed);
    }else{
      this.stop();
    }
    
    rot += (up)?frec:-frec;
    
    super.update(t);
  }
  
  public void setCollisionRadius(){
    this.collider.radius = 7;
  }
}

//------------Movimiento en curva---------------//

class EnemyCurve extends Enemy{
  
  int lifeT;
  
  public EnemyCurve(Vector pos){
    super(pos);
    this.lifeT = 0;
  }
  
  public void update(float t, Player p){
    lifeT = (lifeT >= 360)?0:lifeT;
    if( p != null ){ 
      this.vel = new Vector(1,1);
      this.vel.normalize();
      this.vel.rotate(lifeT);
      Vector aux = p.pos.staticSub(this.pos);
      aux.normalize();
      this.vel.add(aux);
      //this.vel.normalize(speed);
    }else{
      this.stop();
    }
    lifeT++;
    super.update(t);
  }
  
}

//----------speed-------//
class EnemySpeed extends Enemy{
  public EnemySpeed(Vector pos){
    super(pos);
    this.score = 5;
    speed = 2.1;
  }
}

//----------tank---------//
class EnemyTank extends Enemy{
  public EnemyTank(Vector pos){
    super(pos);
    this.hp = 5;
    this.score = 10;
    speed = 0.5;
  }
  
  public void setCollisionRadius(){
    this.collider.radius = 14;
  }
}