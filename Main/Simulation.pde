

class Simulation{
  final int numberOfObjects =200;
  final int widthArea=10;
  final int heightArea=10;
  final int depthArea=10;

  Simulation(){
    StartSimulation();
  }
  
  public void Update(){
    DetectCollision();   
    
    //Update each object
    for(int i=0; i< objects.size();i++){
      objects.get(i).Update();
      objects.get(i).Draw();
    }
  
  }
  
  
  
  
  

  void StartSimulation(){
    //Populate the world
    for(int i=0; i< numberOfObjects; i++){
        float x = random(-widthArea/2,widthArea/2);
        float y = random(-heightArea/2,heightArea/2);
        float z = random(-depthArea/2,depthArea/2);
       AddObjectToScene(new PVector(x,y,z));
    }
    
    //Compute memory usage
    Runtime runtime = Runtime.getRuntime();
    runtime.gc();
    memoryUsed = runtime.totalMemory() - runtime.freeMemory();
  }
  
  void AddObjectToScene(PVector position){
    Object obj = new Object();
    obj.AddMesh(loadShape("Resources/Pyramid.obj"));
    obj.AddCollider(new SphereCollider(obj));
    obj.SetPosition(position);
    
    objects.add(obj);
  }
  
  void DetectCollision(){
    for(int i=0; i< objects.size()-1;i++){
      for(int j=i+1; j<objects.size(); j++){
         CollisionInfo colInfo =  objects.get(i).collider.checkCollision(objects.get(j).collider);
         if(colInfo!=null){
           ResolveCollision(colInfo);
         }
      }
    }
  }
  
  void ResolveCollision(CollisionInfo collision){
      collision.col1.owner.velocity.sub(collision.normal.mult(0.1));
      collision.col1.owner.Update();
      collision.col2.owner.velocity.add(collision.normal.mult(0.1));
      collision.col2.owner.Update();
  }
}