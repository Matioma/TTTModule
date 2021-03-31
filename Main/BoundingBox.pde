class BoundingBox{
  PVector minVector;
  PVector maxVector;
  
  BoundingBox(PVector min, PVector max){
    minVector = min;
    maxVector = max;
  }
  
  
  public PVector GetDiagonal(){
    PVector DiagonalVector =  maxVector.sub(minVector);
    println(DiagonalVector);
    return maxVector.sub(minVector);
  }
}
