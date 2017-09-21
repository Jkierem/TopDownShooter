class EnemyPlanet extends Enemy { //<>// //<>// //<>//
  ArrayList<EnemySatellite> orbits; //orbits him 
  PhysicsEngine engine;
  ArrayList<Vector> base;

  private void planet(int n) {
    base = new ArrayList<Vector>();
    score = 50;
    hp = 9;
    attack = 5;
    speed = 1.3;
    orbits = new ArrayList<EnemySatellite>();
    for ( int i = 0; i < n; i++ ) {
      EnemySatellite aux = new EnemySatellite(this);
      this.orbits.add( aux );
      engine.addEntity(aux);
    }
    placeOrbits();
  }

  public EnemyPlanet( PhysicsEngine engine ) {
    super(new Vector(0, 0));
    this.engine = engine;
    this.planet(6);
  }

  public EnemyPlanet(PhysicsEngine engine, int n ) {
    super(new Vector(0, 0));
    this.engine = engine;
    this.planet(n);
  }

  public EnemyPlanet(PhysicsEngine engine, int n, Vector pos) {
    super(pos);
    this.engine = engine;
    this.planet(n);
  }

  public void setCollisionRadius() {
    this.collider.radius = 13;
  }

  public void update(float t, Player p) {
    if ( p != null ) { 
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
      //this.vel = new Vector(0,0);
    } else {
      this.stop();
    }
    super.update(t);
    updateOrbits();
  }

  public void updateOrbits() {
    for ( EnemySatellite e : orbits ) {
      if ( this.alive ) {
        int index = orbits.indexOf(e);
        base.get(index).rotate(1);
        e.pos = base.get(index).staticAdd(this.pos);
      }
    }
  }

  public void placeOrbits() {
    Vector orbit = new Vector(30, 0);
    for ( EnemySatellite e : orbits) {
      base.add(orbit.cpy());
      e.pos = orbit.staticAdd(this.pos);
      orbit.rotate(360/orbits.size());
    }
  }

  public void die() {
    for ( EnemySatellite e : orbits ) {
      e.die();
    }
    this.alive = !this.alive;
  }
}
//------------SATELLITE---------------------//
class EnemySatellite extends Enemy {
  EnemyPlanet planet;

  public EnemySatellite( EnemyPlanet planet ) {
    super(new Vector(0, 0));
    hp = 5;
    this.planet = planet;
    score = 0;
  }

  public EnemySatellite( EnemyPlanet planet, Vector pos) {
    super(pos);
    hp = 5;
    this.planet = planet;
    score = 0;
  }

  public void setCollisionRadius() {
    this.collider.radius = 7.5;
  }

  public void update(float t, Player p) {
  }
}


//------------cluster------//

class BossCluster extends Enemy {
  PhysicsEngine engine;
  int frames;
  int clusters;

  public BossCluster( PhysicsEngine engine, int clusters) {
    super(new Vector(0, 0));
    this.engine = engine;
    this.clusters = clusters;
    this.speed = 0.4;
    this.score = 0;
    this.attack = 3;
  }

  public BossCluster( PhysicsEngine engine, int clusters, Vector pos) {
    super(pos);
    this.engine = engine;
    this.clusters = clusters;
    this.speed = 0.4;
    this.score = 0;
    this.attack = 3;
  }

  public void setCollisionRadius() {
    this.collider.radius = 25;
  }

  public void update(float t, Player p) {
    if ( p != null ) { 
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
    } else {
      this.stop();
    }
    this.frames+=3;
    this.frames = this.frames%(360/5);
    super.update(t);
  }

  public void die() {

    Vector base = new Vector(0, 50);
    for ( int i = 0; i < this.clusters; i++) {
      EnemyCluster c = new EnemyCluster(this.engine, 10);
      base.rotate(360/(clusters));
      c.birth(this, base.cpy());
      c.addScr = 2;
      engine.addEntity(c);
    }

    this.alive = false;
  }
}

class EnemyCluster extends Enemy {

  PhysicsEngine engine;
  int frames;
  int clusters;
  int addScr;

  public EnemyCluster( PhysicsEngine engine, int clusters) {
    super(new Vector(0, 0));
    this.engine = engine;
    this.clusters = clusters;
    this.speed = 0.8;
    this.addScr = 0;
    this.score = 0;
    this.attack = 2;
  }

  public EnemyCluster( PhysicsEngine engine, int clusters, Vector pos) {
    super(pos);
    this.engine = engine;
    this.clusters = clusters;
    this.speed = 0.8;
    this.addScr = 0;
    this.score = 0;
    this.attack = 2;
  }

  public void setCollisionRadius() {
    this.collider.radius = 15;
  }

  public void update(float t, Player p) {
    if ( p != null ) { 
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
    } else {
      this.stop();
    }
    this.frames+=5;
    this.frames = this.frames%(360/5);
    super.update(t);
  }

  public void die() {

    Vector base = new Vector(0, 100);
    for ( int i = 0; i < this.clusters; i++) {
      Cluster c = new Cluster(new Vector(0, 0));
      base.rotate(360/(clusters));
      c.birth(this, base.cpy());
      c.score += addScr;
      engine.addEntity(c);
    }

    this.alive = false;
  }

  public void birth( BossCluster parent, Vector base) {
    this.pos = parent.pos.staticAdd(base);
  }
}

class Cluster extends Enemy {

  int frames;

  public void die() {
    this.alive = false;
  }

  public Cluster(Vector pos) {
    super(pos);
    this.frames = 0;
    this.speed = 1.7;
    this.attack = 1;
  }

  public void setCollisionRadius() {
    this.collider.radius = 7;
  }

  public void birth( EnemyCluster parent, Vector base) {
    this.pos = parent.pos.staticAdd(base);
  }

  public void update(float t, Player p) {
    if ( p != null ) { 
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
    } else {
      this.stop();
    }
    frames += 7;
    this.frames = this.frames%(360/5);
    super.update(t);
  }
}

//------------SHARK BOSS ----------//

class EnemyShark extends Enemy {

  int frames;
  int refresh;

  public EnemyShark(Vector pos) {
    super(pos);
    hp = 20;
    score = 300;
    attack = 14;
    frames = -60;
  }

  public void setCollisionRadius() {
    this.collider.radius = 5;
  }

  public Vector getColliderCenter() {
    Vector aux = this.vel.cpy();
    aux.normalize(7);
    return this.pos.staticAdd(aux);
  }

  public void update(float t, Player p) {
    frames++;
    if ( p != null ) { 
      int next = 60;
      int til = next + 120;
      if ( frames < 0) {
        this.acc = new Vector(0, 0);
        this.vel = p.pos.staticSub(this.pos);
        this.vel.normalize(1.5);
      }
      if ( frames >= next  && frames <= til) {
        this.acc = p.pos.staticSub(this.pos);
        this.acc.scalarMult(0.01);
      }
      if ( frames > til+60) {
        frames = -40;
      }
    } else {
      this.stop();
    }
    this.maxVel = 5;
    super.update(t);
  }

  public void die() {
    this.alive = false;
  }
}

//----------WORM-------------//

class Zoid extends Enemy {

  int frames;
  Zoid next;//detras en la fila, null si es cola
  Zoid prev;//alante en la fila, null si es cabeza
  Queue<Vector> hist;
  float initSpeed;
  float prevDead;
  
  public void initZoid(int n){
    this.frames = 0;
    this.hist = new Queue<Vector>();
    this.attack = 1;
    this.prev = null;
    this.speed = 1.9;
    this.initSpeed = 1.9;
    this.score = n;
  }

  public Zoid(Vector pos, int n, Zoid parent) {
    super(pos);
    initZoid(n);
    this.prev = parent;
    this.prevDead = 0;
    if ( parent != null ) {
      this.collider.deactivate();
    }
    if ( n > 1) {
      this.next = new Zoid(pos, n-1, this);
    }
  }

  public Zoid(Vector pos, int n) {
    super(pos);
    initZoid(n);
    if ( n >= 1) {
      this.next = new Zoid(pos, n-1, this);
    }
  }

  public void addZoid( Zoid z ) {
    if (next == null) {
      next = z;
      z.prev = this;
    } else {
      next.addZoid(z);
    }
  }

  public void hit(Entity e, Collider c) {
    if ( next != null ) {
      this.next.hit(e, c);
    } else {
      if ( !(e instanceof Enemy) ) {
        if ( e instanceof Player) {
          hp = 0;
        } else {
          hp -= e.attack;
        }
      }
      if ( hp <= 0 ) {
        die();
      }
      c.endCollision();
    }
  }

  public void hit(Entity e) {
    if ( next != null ) {
      this.next.hit(e, this.collider);
    } else if ( next == null && prev == null ) {
      if ( !(e instanceof Enemy) ) {
        if ( e instanceof Player) {
          hp = 0;
        } else {
          hp -= e.attack;
        }
      }
      if ( hp <= 0 ) {
        die();
      }
      this.collider.endCollision();
    }
  }

  public int size() {
    if ( next != null ) {
      return 1 + next.size();
    } else {
      return 1;
    }
  }

  public void calculateSpeed() {
    float s = this.size();
    float dead = score - s;
    //println(initSpeed);
    if ( dead > this.prevDead) {
      this.prevDead = dead;
      this.speed += (1.0/score)*initSpeed;
    }
  }

  public float findSpeed() {
    if ( prev != null ) {
      return prev.findSpeed();
    }
    return this.speed;
  }

  public int calculateMem() {
    float sp = findSpeed();
    return (int)((1/sp)*20);
  }

  public void update( float t, Player p ) {

    if ( this.prev == null) {
      this.hist.push(this.pos);
      if ( p != null ) { 
        this.vel = p.pos.staticSub(this.pos);
        //this.calculateSpeed();
        this.vel.normalize(this.speed);
      } else {
        this.stop();
      }
      super.update(t);
    } else {
      if ( prev.hist.size() >=  10) {
        this.hist.push( this.pos.cpy() );
        this.pos = prev.hist.poll().cpy();
        prev.hist.pop();
      }
    }
    if ( next != null) {
      next.update(t, p);
    }
  }

  public void die() {
    if ( this.prev != null)
      this.prev.next = null;
    this.alive = false;
  }
}



//--------GHOST--------------//

class Ghost extends Enemy {

  public Ghost(Vector pos) {
    super(pos);
  }

  private boolean isSeen(Player p) {
    PVector dir = p.calculateProjDir().toPVector();
    PVector aim = new PVector(this.pos.x - p.pos.x, this.pos.y - p.pos.y);
    float a = degrees(PVector.angleBetween(dir, aim));
    if ( a >= -45 && a <= 45 ) {
      return true;
    }
    return false;
  }

  public void update(float t, Player p) {
    if ( p != null && !this.isSeen(p)) { 
      this.collider.activate();
      this.vel = p.pos.staticSub(this.pos);
      this.vel.normalize(speed);
    } else {
      this.vel = new Vector(0, 0);
      this.collider.deactivate();
    }
    super.update(t);
  }
}

//---------------shooter---------------//

class SnipeMinion extends Snipe{
  public SnipeMinion(Vector pos, PhysicsEngine engine){
    super(pos,engine,150,1);
    this.range = (int)random(155,180);
    this.hp = 3;
    this.projSpeed = 2.2;
    this.maxVel = 1.8;
    this.score = 10;
    this.trate = 3;
  }
}

class SnipeBoss extends Snipe{
  
  public SnipeBoss(Vector pos, PhysicsEngine engine){
    super(pos,engine,150,5);
    this.trate = 5;
    this.range = (int)random(140,160);
  }
}

class GigaSnipe extends Snipe{
  public GigaSnipe(Vector pos, PhysicsEngine engine){
    super(pos,engine,150,30);
    this.hp = 3;
    this.score = 5000;
  }
}

class Snipe extends Enemy {
  int frames;
  float projSpeed;
  PhysicsEngine engine;
  float range;
  float rot;
  int rps;
  int trate;

  public Snipe(Vector pos, PhysicsEngine engine, float range, int rps) {
    super(pos);
    this.frames=-30;
    this.range = range;
    this.projSpeed = 2.5;
    this.engine = engine;
    this.maxVel = 2;
    this.attack = 1;
    this.hp = 5;
    this.score = 25;
    this.rps = rps;
    this.trate = 10;
    this.rot = ((int)random(0,2)) == 0?-1:1;
  }

  public Vector calculateProjDir() {
    Vector dir;
    if ( engine.player != null) {
      dir = engine.player.pos.staticSub(this.pos);
      dir.normalize();
    } else {
      dir = new Vector(1, -1);
    }
    return dir;
  }

  public void fire() {
    //println("firing mah lazer"+ this.frames+random(100));
    engine.addConcurrentEntity( new EnemyProjectile(this) );
  }

  public void update(float t, Player p) {
    if (p != null) {
      frames++;
      float dist = this.pos.distance(p.pos);
      Vector auxvel = new Vector(0, 0);
      auxvel = p.pos.staticSub(this.pos);
      if ( dist < range ) {
        auxvel.rotate(180);
        auxvel.normalize();
      } else if ( dist > range ) {
        auxvel.normalize();
      }
      this.vel =  p.pos.staticSub(this.pos);
      this.vel.normalize();
      this.vel.rotate(90*this.rot);
      this.vel.add(auxvel);
      if ( frames >= (60/this.rps) ) {
        frames = 0;
        int rand = (int)random(100);
        if( rand < trate)
          this.rot *= -1;
        if( !this.isOutOfBounds(this.pos) )
          this.fire();
      }
    } else {
      this.stop();
    }
    super.update(t);
  }
  
  public void setCollisionRadius(){
    this.collider.radius = 15;
  }
}

class EnemyProjectile extends Enemy {

  public EnemyProjectile( Snipe sh ) {
    super(sh.pos);
    Vector dir = sh.calculateProjDir();
    dir.normalize(25);
    this.pos.add(dir);
    this.hp = 1;
    this.score = 0;
    attack = sh.attack;
    //vel = this.calculateDir();
    vel = sh.calculateProjDir();
    vel.normalize(sh.projSpeed);
  }

  public void hit(Entity e) {
    if ( e instanceof Player ) {
      this.hp = 0;
    } else if ( e instanceof Projectile ) {
      this.hp -= e.attack;
    }
    if ( hp <= 0) {
      this.die();
    }
    this.collider.endCollision();
  }

  public void update(float t, Player p) {
    super.update(t);
  }

  public void die() {
    this.alive = false;
  }

  public void setCollisionRadius() {
    this.collider.radius = 6;
  }

  public void boundControl() {
    this.die();
  }
}




//*/