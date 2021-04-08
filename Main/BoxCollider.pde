class BoxCollider extends Collider{
  float XSize = 1;
  float YSize = 1;
  float ZSize = 1;
  
  
  BoxCollider(Object owner){
    super(owner);
    BoundingBox boundingBox = getBoundingBox(owner.getMesh());
    XSize = boundingBox.xSize;
    YSize = boundingBox.ySize;
    ZSize = boundingBox.zSize;
  }
  
  
  void Draw(){
    if(!debugMode) return;
      pushMatrix();
      translate(owner.getPosition().x,owner.getPosition().y,owner.getPosition().z);
      noFill();
      stroke(127,0,0);
      sphereDetail(12);
      box(XSize,YSize,ZSize);

      popMatrix();
  }
  public CollisionInfo checkCollision(Collider col){
    if(col instanceof SphereCollider){
      SphereCollider collider2= (SphereCollider)col; 
      
      PVector colliderPos1 = owner.position.copy();
      PVector colliderPos2 = col.owner.position.copy();
           
      PVector differenceVector= colliderPos2.sub(colliderPos1);
      //float collider1Radius = radius;
      //float collider2Radius = collider2.GetRadius();
           
      //if(differenceVector.mag()<= collider1Radius+collider2Radius){
      //   collisionsCount++;
      //   differenceVector.normalize().mult(1);
      //   return new CollisionInfo(differenceVector,this,collider2);
      //}
    }
    
    if(col instanceof BoxCollider){
      BoxCollider collider2 = (BoxCollider)col;
      
      PVector colliderPos1 = owner.position.copy();
      PVector colliderPos2 = col.owner.position.copy();
      PVector differenceVector= colliderPos2.sub(colliderPos1);
      
      if(abs(differenceVector.x) >(XSize/2+collider2.XSize/2)) return null;
      if(abs(differenceVector.y) >(YSize/2+collider2.YSize/2)) return null;
      if(abs(differenceVector.z) >(ZSize/2+collider2.ZSize/2)) return null;
      
      collisionsCount++;
      differenceVector.normalize().mult(1);
      return new CollisionInfo(differenceVector,this,collider2);
    }
    return null;
  } 



}
