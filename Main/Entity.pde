class Entity{
  Mesh mesh;
  Collider collider;
  Transform transform=new Transform();
  
  Entity(Mesh mesh, Collider collider){
    this.mesh = mesh;
    this.mesh.SetParent(this);
    this.collider = collider;
    this.collider.SetParent(this);
  }
  
  
  void Update(){
    //transform.position.add(new PVector(1,1,0));
    
    collider.Update();
    mesh.Update();
  }
  
  void Draw(){
     mesh.Draw();
     collider.Draw();
    
  }
}
