class Object{
  float _minScale =0;
  float _maxScale =10;


  PShape meshToDraw;
  public PShape getMesh(){return meshToDraw;};
  Collider collider;
  
  PVector position = new PVector(0,0,0);
  public PVector getPosition(){return position.copy();};
  PVector rotation = PVector.random3D();
  public PVector getRotation(){return rotation.copy();};
  PVector scale = new PVector(random(_minScale, _maxScale),random(_minScale, _maxScale),random(_minScale, _maxScale));

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
  
  public void ProcessVertexData(IProcessVertecies cmdToProcessVerticies){
    if(meshToDraw == null) return;
    if(meshToDraw.getChildCount() ==0) return;
    
    PMatrix3D matrix =  GetMatrix();
    
    for(int i=0; i< meshToDraw.getChildCount(); i++){
      cmdToProcessVerticies.processPolygons(meshToDraw.getChild(i),matrix);

      for(int j=0; j<meshToDraw.getChild(i).getVertexCount(); j++){
        cmdToProcessVerticies.processVerticies(meshToDraw.getChild(i).getVertex(j),matrix);
      }
    }
  }

  ArrayList<PVector> getNormals(){
    if(meshToDraw == null) return null;
    if(meshToDraw.getChildCount() ==0) return null;
    
    ArrayList<PVector> normals = new ArrayList<PVector>();
    PMatrix3D matrix =  GetMatrix();
    
    for(int i=0; i< meshToDraw.getChildCount(); i++){
      PVector normal = new PVector();
      PShape poligon =meshToDraw.getChild(i);
      if(poligon.getVertexCount()<3){
        println("not a polygon");
        continue;
      }

      PVector p1 = new PVector();
      matrix.mult(poligon.getVertex(0).copy(),p1);
      PVector p2 = new PVector();
      matrix.mult(poligon.getVertex(1).copy(),p2);
      PVector p3 = new PVector();
      matrix.mult(poligon.getVertex(2).copy(),p3);
    
      PVector edge1 = p2.copy().sub(p1);
      PVector edge2 = p3.copy().sub(p1);

      normal = edge1.cross(edge2);
      normals.add(normal);
    }
    return normals;
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
      if(collider !=null) collider.Draw();
    popMatrix();
  }
}
