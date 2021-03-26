class Mesh{
  Entity parent;
  void SetParent(Entity parent){
    this.parent = parent;
  }
  
  PShape s =createShape();
  
  PVector vertices[] = {
    new PVector(-100, -100, -100),
    new PVector(100, -100, -100),
    new PVector(0,    0,  100),
    
    new PVector(100, -100, -100),
    new PVector(100,  100, -100),
    new PVector( 0,    0,  100),
    
    new PVector(100, 100, -100),
    new PVector(-100, 100, -100),
    new PVector( 0,   0,  100),

    new PVector(-100,  100, -100),
    new PVector(-100, -100, -100),
    new PVector( 0,   0,  100)
  };
  
  PVector vertices2[] = {
    new PVector(-100, -100, -100),
    new PVector(100, -100, -100),
    new PVector(0,    0,  100),
    
    new PVector(100, -100, -100),
    new PVector(100,  100, -100),
    new PVector( 0,    0,  100),
    
    new PVector(100, 100, -100),
    new PVector(-100, 100, -100),
    new PVector( 0,   0,  100),

    new PVector(-100,  100, -100),
    new PVector(-100, -100, -100),
    new PVector( 0,   0,  100)
  };
  
  

  
  Mesh(){
    s.beginShape(TRIANGLE);
    
    for(int i=0;i<vertices2.length;i++){
       Vertex(s,vertices2[i]);
    }
    s.endShape();
  }
  
  void Update(){
  }
  
  void Draw(){
    //if(shape==null) return;
    
    
   pushMatrix();
   translate(parent.transform.position.x, parent.transform.position.y, parent.transform.position.z);
  
   fill(255);
   stroke(127,127,127);
   //box(100,100,100);
  
   //shape(s);
   beginShape();
     for(int i=0;i<vertices.length;i++){
       Vertex(vertices[i]);
     }
   endShape();
   popMatrix();
  }
  
  
  void Vertex(PVector position){
    vertex(position.x, position.y,position.z);
  }
  
  void Vertex(PShape shape,PVector position){
    shape.vertex(position.x, position.y,position.z);
  }
}
