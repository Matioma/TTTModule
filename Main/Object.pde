class Object{
  PShape meshToDraw;
  public PShape getMesh(){return meshToDraw;};
  Collider collider;
  
  PVector position = new PVector(0,0,0);
  public PVector getPosition(){return position.copy();};
  PVector rotation = PVector.random3D();
  public PVector getRotation(){return rotation.copy();};
  PVector scale = PVector.random3D().normalize().mult(5);
  public PVector getScale(){return rotation.copy();};
  
  PVector velocity = new PVector(0,0,0);
  
  PVector minVector;
  PVector maxVector;


  Object(){ 
  }

  PMatrix3D GetMatrix(){
    PMatrix3D matrix  = new PMatrix3D();
    
    matrix.translate(position.x, position.y, position.z);
    matrix.rotateX(rotation.x);
    matrix.rotateY(rotation.y);
    matrix.rotateZ(rotation.y);
    matrix.scale(scale.x);
    
    return matrix;
  }
  
  void ProcessVertexData(IProcessVertecies commandToProcess){
    if(meshToDraw == null) return;
      if(meshToDraw.getChildCount() ==0) return;
      
      PMatrix3D matrix =  GetMatrix();
      
      for(int i=0; i< meshToDraw.getChildCount(); i++){
        for(int j=0; j<meshToDraw.getChild(i).getVertexCount(); j++){
          commandToProcess.processVerticies(meshToDraw.getChild(i).getVertex(j),meshToDraw.getChild(i),matrix);
        }
      }
  }


  void AddMesh(PShape shape){
    meshToDraw = shape;
    
    meshToDraw.resetMatrix();
    meshToDraw.translate(position.x, position.y, position.z);
  }
  
  void AddCollider(Collider collider){
    this.collider = collider;
  }
  
  void SetPosition(PVector position){
    this.position= position;
    BoundingBox boundingBox = collider.getBoundingBox(meshToDraw); 
  }
 
  void Update(){
     position.add(velocity);
     velocity.mult(0);
  }
  
  void Draw(){
    if(meshToDraw ==null) return;

    ProcessVertexData(new DrawVerticies());
    
    DrawTheMesh();
    DrawCollider();
  }
  
  
  void DrawTheMesh(){
    pushMatrix();
      translate(position.x, position.y, position.z);
      rotateX(rotation.x);
      rotateY(rotation.y);
      rotateZ(rotation.y);
      scale(scale.x);
      
      if(seeMeshes) shape(meshToDraw);
    popMatrix();
  }
  
  void DrawCollider(){
     pushMatrix();
      translate(position.x, position.y, position.z);
      if(collider !=null) collider.Draw();
    popMatrix();
  }
  
}
