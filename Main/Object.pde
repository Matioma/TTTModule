class Object{
  PShape meshToDraw;
  Collider collider;
  
  PVector position = new PVector(0,0,0);
  PVector rotation = PVector.random3D();
  
  PVector velocity = new PVector(0,0,0);
  
  Object(){ }
  
  void AddMesh(PShape shape){
    meshToDraw = shape;
  }
  
  void AddCollider(Collider collider){
    this.collider = collider;
  }
  
  void SetPosition(PVector position){
    this.position= position;
  }
 
  void Update(){
     position.add(velocity);
     velocity.mult(0);
  }
  
  void Draw(){
    if(meshToDraw ==null) return;
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    
    noStroke();
    shape(meshToDraw);
    
    if(collider !=null) collider.Draw();
  
    popMatrix();
  }
}
