interface IProcessVertecies{
    void processVerticies(PVector vertex, PMatrix3D matrix);
    void processPolygons(PShape poligon, PMatrix3D matrix);
}


class DrawVerticies implements IProcessVertecies{
  void processVerticies(PVector vertex, PMatrix3D matrix){
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

  void processPolygons(PShape poligon, PMatrix3D matrix){

  }
}


class PrintNormals implements IProcessVertecies{
  void processVerticies(PVector vertex, PMatrix3D matrix){
    
  }

  void processPolygons(PShape poligon, PMatrix3D matrix){
    PVector normal = new PVector();

    if(poligon.getVertexCount()<3){
      println("not a polygon");
      return;
    }
    PVector p1 = new PVector();
    matrix.mult(poligon.getVertex(0).copy(),p1);
    PVector p2 = new PVector();
    matrix.mult(poligon.getVertex(1).copy(),p2);
    PVector p3 = new PVector();
    matrix.mult(poligon.getVertex(2).copy(),p3);
   
    PVector edge1 = p2.copy().sub(p1);
    PVector edge2 = p3.copy().sub(p1);

    normal = edge1.cross(edge2).mult(1);
    normal.normalize();
    normal.mult(3);

    DrawUtil util = new DrawUtil();

    pushMatrix();
    stroke(127,0,0);
    fill(255,0,0);
    for(int j=0; j<poligon.getVertexCount(); j++){
      PVector resultVector= new PVector();
      matrix.mult(poligon.getVertex(j),resultVector);
      
      PVector startNormal= new PVector();
      matrix.mult(poligon.getVertex(j).copy(),startNormal);
    
      PVector endNormal = startNormal.copy().add(normal);
      
      
      util.DrawVector(startNormal,endNormal);
    }
    popMatrix();
  }


}