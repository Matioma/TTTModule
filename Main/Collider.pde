abstract class Collider{
  protected Object owner; 
 
  Collider(Object owner){
    this.owner = owner;
  }
  
  void Update(){

  }
  
  public BoundingBox getBoundingBox(PShape meshToDraw){
    if(meshToDraw == null) return null;
    if(meshToDraw.getChildCount() ==0) return null;
    
    PMatrix3D matrix =  owner.GetMatrix();
    
    PVector firstVertex =new PVector();
    matrix.mult(meshToDraw.getChild(0).getVertex(0),firstVertex);
    
    float minX = firstVertex.x;
    float minY = firstVertex.y;
    float minZ = firstVertex.z;
 
    float maxX = firstVertex.x; 
    float maxY = firstVertex.y;
    float maxZ =firstVertex.z;
    
    
    for(int i=0; i< meshToDraw.getChildCount(); i++){
      for(int j=0; j<meshToDraw.getChild(i).getVertexCount(); j++){
        PVector resultVector= new PVector();
        matrix.mult(meshToDraw.getChild(i).getVertex(j),resultVector);
        
        if(resultVector.x < minX) minX = resultVector.x;
        if(resultVector.y < minY) minY = resultVector.y;
        if(resultVector.z < minZ) minZ = resultVector.z;
        
        if(resultVector.x > maxX) maxX = resultVector.x;
        if(resultVector.y > maxY) maxY = resultVector.y;
        if(resultVector.z > maxZ) maxZ = resultVector.z;   
      }
    }
    
    PVector vec1 =new PVector(minX,minY,minZ);
    PVector vec2 =new PVector(maxX,maxY,maxZ);  
    vec2.sub(vec1);
    
    float xSize = abs(vec2.x);
    float ySize = abs(vec2.y);
    float zSize = abs(vec2.z);
    return new BoundingBox(xSize,ySize,zSize);
  }
  
  abstract void Draw();
  abstract CollisionInfo checkCollision(Collider col);
}
