class Object{
  PShape meshToDraw;
  Collider collider;
  
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
    drawCollider();
  }


  void drawCollider(){
    noFill();
    stroke(127,0,0);
    sphere(1);
  }
}
