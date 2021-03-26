class Collider{
  Object owner; 
  
  Collider(Object owner){
    this.owner = owner;
  }
  
  void Update(){

  }
  
  void Draw(){
    noFill();
    stroke(127,0,0);
    sphere(1);
  }
}
