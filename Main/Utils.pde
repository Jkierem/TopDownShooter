class Queue<T>{
  ArrayList<T> q;
  
  public Queue(){
    this.q = new ArrayList<T>();
  }
  
  public void push( T e1){
    this.q.add(e1);
  }
  
  public T poll(){
    return this.q.get(0);
  }
  
  public void pop(){
    this.q.remove(0);
  }
  
  public int size(){
    return this.q.size();
  }
  
}

class ScriptReader{
  
}

class Script{
  ArrayList<Wave> waves;
  int currentWave;
  
  Script(){
    waves = new ArrayList<Wave>();
    currentWave = 0;
  }
  
  void next(){
    currentWave++;
  }
  
  ArrayList<Single> getCurrentRound(){
    return waves.get(currentWave).getCurrentRound();
  }
  
}

class Wave{
  ArrayList<Round> rounds;
  int currentRound;
  boolean end;
  
  Wave(){
    rounds = new ArrayList<Round>();
    currentRound = 1;
    end = false;
  }
  
  void next(){
    currentRound++;
    if( currentRound > rounds.size() ){
      this.end = true;
    }
  }
  
  ArrayList<Single> getCurrentRound(){
    return rounds.get(currentRound).spawns;
  }
}

class Round{
  ArrayList<Single> spawns;
  
  Round(){
    spawns = new ArrayList<Single>();
  }
}

class Single{
  int id;
  int count;
}