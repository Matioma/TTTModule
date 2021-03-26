class Collider{
  Object owner; 
  float radius=1;
  
  Collider(Object owner){
    this.owner = owner;
  }
  
  void Update(){

  }
  
  void Draw(){
    if(!debugMode) return;
    noFill();
    stroke(127,0,0);
    sphere(radius);
  }
}
