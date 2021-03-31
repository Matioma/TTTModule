class SphereCollider extends Collider{
  float radius=1;
  
  public float GetRadius(){ return radius;}
  
  
  SphereCollider(Object owner){
    super(owner);
  }
  
  void Draw(){
    if(!debugMode) return;
    noFill();
    stroke(127,0,0);
    sphere(radius);
  }
  
  
  public CollisionInfo checkCollision(Collider col){
    if(col instanceof SphereCollider){
      SphereCollider collider2= (SphereCollider)col; 
      
      PVector colliderPos1 = owner.position.copy();
      PVector colliderPos2 = col.owner.position.copy();
           
      PVector differenceVector= colliderPos2.sub(colliderPos1);
      float collider1Radius = radius;
      float collider2Radius = collider2.GetRadius();
           
      if(differenceVector.mag()<= collider1Radius+collider2Radius){
         collisionsCount++;
         differenceVector.normalize().mult(1);
         return new CollisionInfo(differenceVector,this,collider2);
      }
    }
    return null;
  } 
}
