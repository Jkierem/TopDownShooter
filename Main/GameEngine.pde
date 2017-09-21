enum State{
  MENU(0),
  PAUSED(1),
  PLAY(2),
  GAMEOVER(3);
  
  int id;
  
  private State(int id){
    this.id = id;
  }
}

enum Action{
  START("START"),
  DIE("DIE"),
  PAUSE("PAUSE"),
  RESUME("RESUME"),
  QUIT("QUIT");
  
  String name;
  private Action( String name ){
    this.name = name;
  }
}

class GameEngine{
  State state;
  PhysicsEngine engine;
  
  public GameEngine(){
    engine = null;
    state = State.MENU;
  }
  
  public void keyHandle( char k ){
    switch(k){
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
    case 'p':
      if( this.state == State.PLAY)
        dispatch(Action.PAUSE);
      else if( this.state == State.PAUSED )
        dispatch(Action.RESUME);
    break;
    default:
    break;
  }
  }
  
  public void dispatch( Action a ){
    switch(a){
      case START:
        this.startGame();
      break;
      case PAUSE:
        this.pauseGame();
      break;
      case RESUME:
        this.resumeGame();
      break;
      case QUIT:
        this.quitGame();
      break;
      case DIE:
        this.looseGame();
      break;
    }
  }
  
  public void startGame(){
    if( this.state == State.MENU ){
      this.state = State.PLAY;
      //to do: set game
      
    }
  }
  
  public void looseGame(){
    if( this.state == State.PLAY ){
      this.state = State.GAMEOVER;
      //go to gameover screen
    }
  }
  
  public void pauseGame(){
    if( this.state == State.PLAY ){
      this.state = State.PAUSED;
      //pause game (do not update)
    }
  }
  
  public void quitGame(){
    if( this.state == State.PAUSED || this.state == State.GAMEOVER ){
      this.state = State.MENU;
      //go to menu from gameover or paused screen
    }
  }
  
  public void resumeGame(){
    if( this.state == State.PAUSED ){
      this.state = State.PLAY;
      //just this
    }
  }
  
  public void keyControl(){}
}