class Object{
  PShape meshToDraw;
  Collider collider;
  
  PVector position;
  
  Object(){ }
  
  void AddMesh(PShape shape){
    meshToDraw = shape;
  }
  
  void AddCollider(Collider collider){
    this.collider = collider;
  }
 
  void Update(){
    
  }
  
  
  void Draw(){
    if(meshToDraw ==null) return;
    
    noStroke();
    shape(meshToDraw);
    meshToDraw.rotateY(.01);
    
    if(collider !=null) collider.Draw();
  }
}
