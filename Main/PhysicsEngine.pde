import java.util.Iterator;

class PhysicsEngine {

  float t;
  Plotter plot;
  Player player;
  ArrayList<Entity> entities;
  ArrayList<Entity> avoidConcurrent;
  int spawn;
  int score;
  int hitCounter;

  public PhysicsEngine( float t, int spawn) {
    this.t = t;
    this.plot = new Plotter(this);
    this.entities = new ArrayList<Entity>();
    this.avoidConcurrent = new ArrayList<Entity>();
    this.player = null;
    this.spawn = spawn;
    this.hitCounter = 0;
  } 

  public void addConcurrentEntity( Entity e ) {
    this.avoidConcurrent.add(e);
  }

  public void addEntity( Entity e ) {
    if ( e instanceof Player ) {
      this.player = (Player)e;
    }
    this.entities.add(e);
  }

  public void checkEntities() {
    Iterator<Entity> i = entities.iterator();
    while ( i.hasNext() ) {
      Entity e = i.next();
      if ( !e.alive ) {
        if ( e instanceof Enemy ) {
          score += ((Enemy)e).score;
        }
        i.remove();
      }
    }
  }

  public void updatePositions() {
    for (Entity e : entities) {
      if (e instanceof Enemy ) {
        ((Enemy)e).update(this.t, this.player);
      } else {
        e.update(this.t);
      }
    }
    if ( avoidConcurrent.size() >= 0) {
      entities.addAll(avoidConcurrent);
      avoidConcurrent.clear();
    }
  }

  public void checkCollisions() {
    for ( int i = 0; i < entities.size(); i++ ) {
      for ( int j = i+1; j < entities.size(); j++ ) {
        if ( entities.get(i).collider.didCollide( entities.get(j).collider ) ) {
          entities.get(i).hit( entities.get(j) );
          entities.get(j).hit( entities.get(i) );
        }
      }
    }
  }

  public void update() {
    updatePositions();
    checkCollisions();
    checkEntities();
    plot.plotGame();
  }

  public void spawn( int n ) {
    for ( int i = 0; i < n; i++) {
      Vector initPos = new Vector(0, 0);
      int side = int(random(4));
      switch(side) {
      case 0:
        initPos = new Vector( random(width), 0);
        break;
      case 1:
        initPos = new Vector( width, random(height) );
        break;
      case 2:
        initPos = new Vector( random(width), height);
        break;
      case 3:
        initPos = new Vector( 0, random(height) );
        break;
      }
      Enemy e = createRandomEnemy(initPos);
      this.addEntity(e);
    }
  }

  public int countProjs() {
    int c = 0;
    for ( Entity e : entities )
      if ( e instanceof Projectile)
        c++;
    return c;
  }

  public Enemy createRandomEnemy( Vector pos ) {
    //choose enemy type
    int mod = 1;
    if ( score > 20) {
      mod++;
      if ( score > 40) {
        mod++;
      }
      if ( score > 100) {
        mod+=2;
      }
    }
    int type = int(random(mod));
    //create enemy
    Enemy e;
    switch(type) {
    case 0:
      e = new Enemy(pos);
      break;
    case 1:
      e = new EnemyTank(pos);
      break;
    case 2:
      e = new EnemySpeed(pos);
      break;
    case 3:
      e = new EnemySin(pos);
      break;
    case 4:
      e = new EnemyCurve(pos); 
      break;
    default:
      e = new Enemy(pos);
      break;
    }
    //return enemy
    return e;
  }

  public boolean hit() {
    if ( hitCounter > 0) {
      this.hitCounter--;
    }
    if ( hitCounter == 0) {
      return false;
    }
    return true;
  }
  
  //-------important----------//

  public Vector chooseRandomSide() {
    Vector initPos = new Vector(0,0);
    int side = int(random(4));
    switch(side) {
    case 0:
      initPos = new Vector( random(width), 0);
      break;
    case 1:
      initPos = new Vector( width, random(height) );
      break;
    case 2:
      initPos = new Vector( random(width), height);
      break;
    case 3:
      initPos = new Vector( 0, random(height) );
      break;
    }
    return initPos;
  }
  
  public void spawn( int id , Vector pos ){
    Enemy e;
    switch(id){
      
      //SECRET
      
      case -1:
        e = new GigaSnipe(pos.cpy(),this);
      break;
      
      //BASIC
      
      case 0:
        e = new Enemy(pos.cpy());
      break;
      case 1:
        e = new EnemySin(pos.cpy());
      break;
      case 2:
        e = new EnemyCurve(pos.cpy());
      break;
      case 3:
        e = new EnemySpeed(pos.cpy());
      break;
      case 4:
        e = new EnemyTank(pos.cpy());
      break;
      case 5:
        e = new EnemyCluster(this,5,pos.cpy());
      break;
      case 6:
        e = new Ghost(pos);
      break;
      case 7:
        e = new SnipeMinion(pos.cpy(),this);
      break;
      
      //BOSS
      
      case 8:
        e = new EnemyPlanet(this,6,pos.cpy());
      break;
      case 9:
        e = new BossCluster(this,3,pos.cpy());
      break;
      case 10:
        e = new EnemyShark(pos.cpy());
      break;
      case 11:
        e = new Zoid(pos.cpy(),20);
      break;
      case 12:
        e = new SnipeBoss(pos.cpy(),this);
      break;
      default:
        e = new Enemy(pos);
      break;
    }
    
    this.addEntity(e);
  }
  
  public void runScript(){
    
  }
  
  public void startGame(){
    this.player = new Player(new Vector(width/2,height/2) );
    this.addEntity(this.player);
    
  }
  
  
}