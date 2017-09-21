class Collider{
  
  public Entity e;
  public float radius;
  private boolean active;
  private boolean colliding;

  public Collider( Entity e , float radius){
    this.e = e;
    this.radius = radius;
    this.active = true;
    this.colliding = false;
  }
  
  public void deactivate(){
    this.active = false;
  }
  
  public void activate(){
    this.active = true;
  }
  
  public boolean isActive(){
    return this.active;
  }
  
  public void endCollision(){
    this.colliding = false;
  }
  
  public Vector getCenter(){
    return e.getColliderCenter();
  }
  
  public boolean didCollide( Collider c1 ){
    if( c1.isActive() && this.isActive() && !this.colliding && !c1.colliding){
      float dist = (this.getCenter().staticSub(c1.getCenter()).modulo());
      float radii = this.radius + c1.radius;
      if( radii >= dist){
        this.colliding = true;
        return true;
      }
    }
    return false;
  }
  
}