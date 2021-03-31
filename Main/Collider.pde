abstract class Collider{
  protected Object owner; 
 
  
  Collider(Object owner){
    this.owner = owner;
  }
  
  void Update(){

  }
  
  abstract void Draw();
  abstract CollisionInfo checkCollision(Collider col);
}
