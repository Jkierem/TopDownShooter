Player p;
PhysicsEngine engine;
boolean keys[];
Vector vels[];
Enemy en;

int frame = 0;

void setup(){
 
  noCursor();
  //noLoop();
  size(600,600);
  keys = new boolean[4];
  for( int i = 0 ; i < 4 ; i++ ){ keys[i] = false;}
  
  vels = new Vector[4];
  vels[0] = new Vector(0,-2);
  vels[1] = new Vector(0,2);
  vels[2] = new Vector(2,0);
  vels[3] = new Vector(-2,0);
  
  p = new Player( new Vector(height/2,width/2) );
  engine = new PhysicsEngine(1,120);
  engine.addEntity(p);
  p.engine = engine;
<<<<<<< HEAD
  //engine.spawn(-1, engine.chooseRandomSide() );
=======
  engine.spawn(2, engine.chooseRandomSide() );
>>>>>>> aa98a72a06d8284d103cfd10fde1922e58309091
  /*for(int i = 0 ; i < 3 ; i++ )
    engine.spawn(i,engine.chooseRandomSide());*/
}

void draw(){
  frame++;
  engine.update(); //<>//
  
  /*if( frame >= engine.spawn && engine.player != null ){
    frame = 0;
    int n = int(random(1,4));
    engine.spawn(n);
  }
  //*/
  
}

boolean isAnyKeyPressed(){
  for( int i = 0 ; i < 4 ; i++ ){
    if( keys[i] ){
      return true;
    }
  }
  return false;
}

Vector getVel(){
  Vector vel = new Vector(0,0);
  for( int i = 0 ; i < 4 ; i++){
    if( keys[i] ){
      vel.add(vels[i]);
    }
  }
  vel.normalize(2);
  return vel;
}

void keyPressed(){
  switch(key){
    case 'w':
      keys[0] = true;
      //p.acc = new Vector(0,-0.1);
    break;
    case 's':
      keys[1] = true;
      //p.acc = new Vector(0,0.1);
    break;
    case 'd':
      keys[2] = true;
      //p.acc = new Vector(0.1,0);
    break;
    case 'a':
      keys[3] = true;
      //p.acc = new Vector(-0.1,0);
    break;
    /*case 'f':
      if( engine.player != null)
        engine.player.fire();
    break;//*/
    default:
    break;
  }
  //p.acc = getAccel();
  p.vel = getVel();
}

void keyReleased(){
  if(p.alive){
  switch(key){
    case 'w':
      keys[0] = false;
      if( !isAnyKeyPressed() )
        p.stop();
    break;
    case 's':
      keys[1] = false;
      if( !isAnyKeyPressed() )
        p.stop();
    break;
    case 'd':
      keys[2] = false;
      if( !isAnyKeyPressed() )
        p.stop();
    break;
    case 'a':
      keys[3] = false;
      if( !isAnyKeyPressed() )
        p.stop();
    break;
  }
  p.vel = getVel();
  }
}

void mousePressed(){
  if(p.alive)
    p.fire();
}