class Collider{
  Entity parent;
  
  void SetParent(Entity parent){
    this.parent = parent;
  }
  
  
  
  Collider(){    
  }
  void Update(){
  }
  
  void Draw(){
    if(!debugMode) return;
    if(parent == null) println("Parrent was not set");  
    
    pushMatrix();
    PVector position = parent.transform.position;
    translate(position.x, position.y, position.z);
    noFill();
    stroke(127,0,0);
    shapeMode(CENTER);
    sphere(10);
    popMatrix();
  }
  
}
