class BoxCollider extends Collider{
  float XSize = 1;
  float YSize = 1;
  float ZSize = 1;

  PVector min;
  PVector max;
  public PVector getMin(){
    return owner.getPosition().copy().add(new PVector(-XSize/2, -YSize/2, -ZSize/2));
  }
  public PVector getMax(){
     return owner.getPosition().copy().add(new PVector(XSize/2, YSize/2, ZSize/2));
  }


  BoxCollider(Object owner){
    super(owner);
    BoundingBox boundingBox = getBoundingBox(owner.getMesh());
    XSize = boundingBox.xSize;
    YSize = boundingBox.ySize;
    ZSize = boundingBox.zSize;
    //min = owner.getPosition().copy().add(new PVector(-XSize/2, -YSize/2, -ZSize/2));
    //max = owner.getPosition().copy().add(new PVector(XSize/2, YSize/2, ZSize/2));
  }
  
  void Draw(){
    if(!debugMode) return;
      pushMatrix();
      translate(owner.getPosition().x,owner.getPosition().y,owner.getPosition().z);
      noFill();
      stroke(127,0,0);
      sphereDetail(12);
      box(XSize, YSize, ZSize);
      popMatrix();
  }
  public CollisionInfo checkCollision(Collider col){
    if(col instanceof BoxCollider){
      BoxCollider collider2 = (BoxCollider)col;
      
      PVector colliderPos1 = owner.position.copy();
      PVector colliderPos2 = col.owner.position.copy();
      PVector differenceVector= colliderPos2.sub(colliderPos1);
      
      if(abs(differenceVector.x) >(XSize/2+collider2.XSize/2)) return null;
      if(abs(differenceVector.y) >(YSize/2+collider2.YSize/2)) return null;
      if(abs(differenceVector.z) >(ZSize/2+collider2.ZSize/2)) return null;
      
      
      differenceVector.normalize().mult(1);
      return new CollisionInfo(differenceVector,this,collider2);
    }
    return null;
  } 



}
