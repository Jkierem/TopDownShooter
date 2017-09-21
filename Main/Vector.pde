class Vector{
  float x;
  float y;
  
  public Vector(){
    this.x = 0;
    this.y = 0;
  }
  
  public Vector(float x , float y){
    this.x = x;
    this.y = y;
  }
  
  public float modulo(){
    return (float)Math.sqrt( x*x + y*y );
  }
  
  public void div(float d){
     x /= d;
     y /= d;
  }
  
  public void scalarMult(float m){
    x *= m;
    y *= m;
  }
  
  public Vector staticScalarMult( float m ){
    return new Vector( x*m , y*m );
  }
  
  public void add( Vector v1 ){
    this.x += v1.x;
    this.y += v1.y;
  }
  
  public Vector staticAdd( Vector v1 ){
    Vector res = this.cpy();
    res.add(v1);
    return res;
  }
  
  public void sub( Vector v1 ){
    this.x -= v1.x;
    this.y -= v1.y;
  }
  
  public Vector staticSub(Vector v1){
    Vector aux = this.cpy();
    aux.sub(v1);
    return aux;
  }
  
  public void normalize(){
    if(this.modulo() != 0 ){
      this.div(this.modulo());
    }else{ 
      this.div(1);
    }
  }
  
  public void normalize(float n){
    this.normalize();
    this.scalarMult(n);
  }
  
  public Vector cpy(){
    return new Vector(x,y);
  }
  
  public float distance( Vector v1 ){
    return new Vector( this.x - v1.x , this.y - v1.y).modulo();
  }
  
  public void rotate( float degrees ){
    float t = radians(degrees);
    ArrayList<Vector> m = new ArrayList<Vector>();
    m.add( new Vector((float)cos(t),(float)sin(t)) );
    m.add( new Vector(-1*(float)sin(t),(float)cos(t)) );
    
    //println( "matriz[0]" + m.get(0) );
    //println( "matriz[1]" + m.get(1) );
    Vector aux = this.cpy();
    aux.x = this.x * m.get(0).x + this.y * m.get(1).x;
    aux.y = this.x * m.get(0).y + this.y * m.get(1).y;
    this.x = aux.x;
    this.y = aux.y;
  }
  
  public Vector staticRotate(float degrees){
    Vector res = this.cpy();
    res.rotate(degrees);
    return res;
  }
  
  public String toString(){
    return this.x + "," + this.y;
  }
  
  public PVector toPVector(){
    return new PVector(this.x,this.y);
  }
  
}