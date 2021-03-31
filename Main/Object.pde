class Object{
  PShape meshToDraw;
  public PShape getMesh(){return meshToDraw;};
  
  Collider collider;
  
  PVector position = new PVector(0,0,0);
  public PVector getPosition(){return position.copy();};
  PVector rotation = PVector.random3D();
  public PVector getRotation(){return rotation.copy();};
  
  PVector velocity = new PVector(0,0,0);
  
  
  
  Object(){ 
    
  }
  
  
  
  public void VertexData(){
    println( "----------------Face Count Children----------------");
    println(  meshToDraw.getChildCount());
    
    for(int i=0; i< meshToDraw.getChildCount(); i++){
      println(i+ ":  Child");
      for(int j=0; j<meshToDraw.getChild(i).getVertexCount(); j++){
        PVector resultVector= new PVector();
        GetMatrix().mult(meshToDraw.getChild(i).getVertex(j),resultVector);
        println(resultVector);
      }
    }
  }
  
  PMatrix3D GetMatrix(){
    PMatrix3D matrix  = new PMatrix3D();
    matrix.translate(position.x, position.y, position.z);
    matrix.rotateX(rotation.x);
    matrix.rotateY(rotation.y);
    matrix.rotateZ(rotation.y);
    return matrix;
  }
  
  
  void AddMesh(PShape shape){
    meshToDraw = shape;
    
    meshToDraw.resetMatrix();
    meshToDraw.translate(position.x, position.y, position.z);
     
    VertexData();
  }
  
  void AddCollider(Collider collider){
    this.collider = collider;
  }
  
  void SetPosition(PVector position){
    this.position= position;
  }
 
  void Update(){
     rotation.add(new PVector(0.01,0,0));
     position.add(velocity);
     velocity.mult(0);
  }
  
  void Draw(){
    if(meshToDraw ==null) return;
    VertexData();
    
    meshToDraw.resetMatrix();
    meshToDraw.applyMatrix(GetMatrix());
    
   
    pushMatrix();
    
    
    //noStroke();
    if(seeMeshes) shape(meshToDraw);
    
    if(collider !=null) collider.Draw();
  
    popMatrix();
  }
}
