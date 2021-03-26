class CollisionInfo{
  PVector normal; 
  Collider col1; 
  Collider col2;
  
  CollisionInfo(PVector normal, Collider col1, Collider col2){
    this.normal = normal;
    this.col1 = col1;
    this.col2 =col2;
  }
}
