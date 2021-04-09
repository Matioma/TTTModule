
abstract class Simulation{
  final int numberOfObjects =50;
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
  
  abstract void AddObjectToScene(PVector position);
  
  void DetectCollision(){
    for(int i=0; i< objects.size()-1;i++){
      for(int j=i+1; j<objects.size(); j++){
        CollisionInfo colInfo =collisionDetectionMethod(objects.get(i),objects.get(j));
        if(colInfo!=null){
          ResolveCollision(colInfo);
        }
      }
    }
  }

  protected CollisionInfo  collisionDetectionMethod(Object firstObject, Object secondObject){
    return firstObject.collider.checkCollision(secondObject.collider);
  }
  
  void ResolveCollision(CollisionInfo collision){
      collisionsCount++;
      collision.col1.owner.velocity.sub(collision.normal.mult(0.1));
      collision.col1.owner.Update();
      collision.col2.owner.velocity.add(collision.normal.mult(0.1));
      collision.col2.owner.Update();
  }
}
