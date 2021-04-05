interface IProcessVertecies{
    void processVerticies(PVector vertex, PShape poligon, PMatrix3D matrix);
}


class DrawVerticies implements IProcessVertecies{
    void processVerticies(PVector vertex, PShape poligon, PMatrix3D matrix){
    PVector resultVector= new PVector();
    matrix.mult(vertex,resultVector);
    
    if(showVerticies){
      pushMatrix();
      translate(resultVector.x, resultVector.y, resultVector.z);
      stroke(0,127,0);
      sphereDetail(3);
      sphere(0.4);
      popMatrix();
    }
  }
}