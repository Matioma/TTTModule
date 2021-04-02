class BoundingBox{
  PVector minVector;
  PVector maxVector;
  
  float xSize =0;
  float ySize =0;
  float zSize =0;
  
  BoundingBox(float pXSize, float pYSize, float pZSize){
    xSize =pXSize;
    ySize = pYSize;
    zSize = pZSize;
  }
  
   BoundingBox(PVector min, PVector max){
    minVector = min;
    maxVector = max;
  }
  
  
  public float GetCircumscribedSphereRadius(){
    float maxDimension = xSize;
    if(ySize >maxDimension) maxDimension = ySize;
    if(zSize > maxDimension) maxDimension = zSize;
    
    
    return maxDimension/2;
  }
  
  public void Draw(PVector position){
      pushMatrix();
        translate(position.x, position.y, position.z);
        noFill();
        stroke(127,127,0);
        sphereDetail(15);
        box(xSize,ySize, zSize);
      popMatrix();  
  }
}
