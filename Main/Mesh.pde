class Mesh{
  Entity parent;
  void SetParent(Entity parent){
    this.parent = parent;
  }
  
  PShape mesh;
 
  
  Mesh(PShape mesh){
    this.mesh = mesh;
 println(this.mesh.getChildCount());
  }
  
  void Update(){
  }
  
  void Draw(){
    
    pushMatrix();
    shapeMode(CENTER);
    translate(parent.transform.position.x, parent.transform.position.y, parent.transform.position.z);
    scale(parent.transform.scale.x, parent.transform.scale.y, parent.transform.scale.z);
    
    rotateX(10);
    rotateY(parent.transform.rotation.y);
    rotateZ(parent.transform.rotation.z);
    
    fill(255);
    stroke(255);
    box(10,10,10);
    //shape(mesh);
    //box(parent.transform.scale.x, parent.transform.scale.y,parent.transform.scale.z);
    popMatrix();
  }
  
}
