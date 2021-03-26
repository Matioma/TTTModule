class Object{
  PShape meshToDraw;
  Collider collider;
  
  PVector position = new PVector(0,0,0);
  
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
     
  }
  
  void Draw(){
    if(meshToDraw ==null) return;
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    
    noStroke();
    shape(meshToDraw);
    meshToDraw.rotateY(.01);
    
    if(collider !=null) collider.Draw();
  
    popMatrix();
  }
}
