class SphereCollider extends Collider{
  float radius=1;
  
  public float GetRadius(){ return radius;}
  
  SphereCollider(Object owner){
    super(owner);
    BoundingBox boundingBox = getBoundingBox(owner.getMesh());
    
    radius = boundingBox.GetCircumscribedSphereRadius();
    //radius =sqrt(3);
  }
  
  
  void Draw(){
    if(!debugMode) return;
      pushMatrix();
      noFill();
      stroke(127,0,0);
      sphereDetail(12);
      sphere(radius);
      popMatrix();
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
