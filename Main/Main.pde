import peasy.*;



//ArrayList<Entity> entities = new ArrayList<Entity>();

//PShape usedShape;




//void setup() {
//  size(1280, 640, P3D);
//  cam = new PeasyCam(this, 1000);
//  cam.setMinimumDistance(50);
//  cam.setMaximumDistance(5000);
  
//  Mesh usedMesh = new Mesh();
//  Collider collider = new SphereCollider();
  
//  entities.add(createNewEntity(usedMesh,collider));  
//}

//void draw() {

//  background(0);
//  lights();
//  for(int i =0; i< entities.size(); i++){
//    entities.get(i).Update();
//    entities.get(i).Draw();
//  }  
//}


//Entity createNewEntity(Mesh m , Collider col){
//  Entity obj = new Entity(m,col);
//  //obj.transform.position = new PVector(0,0,0);
  
//  return obj;
//}



//void keyReleased() {
//   if (key == 'd' || key == 'D') {
//     ToggleDebugMode();
//   }
//}


//void ToggleDebugMode(){
//  debugMode = !debugMode;
//}

PeasyCam cam;

ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<CollisionInfo> collisions = new ArrayList<CollisionInfo>();

static boolean debugMode=false;

final int numberOfObjects =500;

final int widthArea=10;
final int heightArea=10;
final int depthArea=10;


void setup() {
  size(512, 512, P3D);
  
  
  for(int i=0; i< numberOfObjects; i++){
      float x = random(-widthArea/2,widthArea/2);
      float y = random(-heightArea/2,heightArea/2);
      float z = random(-depthArea/2,depthArea/2);
     AddObjectToScene(new PVector(x,y,z));
  }
 
  
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
}

void draw() {
  background(0);
  lights();
  
  DetectCollision();
  ResolveCollision();
  
  
  
  for(int i=0; i< objects.size();i++){
    objects.get(i).Update();
    objects.get(i).Draw();
  }
}


void AddObjectToScene(PVector position){
  Object obj = new Object();
  obj.AddMesh(loadShape("Resources/Pyramid.obj"));
  obj.AddCollider(new Collider(obj));
  obj.SetPosition(position);
  objects.add(obj);
}


void DetectCollision(){
  for(int i=0; i< objects.size()-1;i++){
    for(int j=i+1; j<objects.size(); j++){
       PVector colliderPos1 = objects.get(i).position.copy();
       PVector colliderPos2 = objects.get(j).position.copy();
       
       PVector differenceVector= colliderPos2.sub(colliderPos1);
       float collider1Radius = objects.get(i).collider.radius;
       float collider2Radius = objects.get(j).collider.radius;
       
       if(differenceVector.mag()<= collider1Radius+collider2Radius){
         //println(differenceVector.mag() + ":" + collider1Radius+collider2Radius);
         
         
         differenceVector.normalize().mult(1);
         ResolveCollision(new CollisionInfo(differenceVector,objects.get(i).collider,objects.get(j).collider));
         //ResolveCollision(differenceVector,objects.get(i).collider,objects.get(j).collider);
       }
    }
  }
}

void ResolveCollision(){
  for(int i=0; i< collisions.size();i++){
    CollisionInfo info = collisions.get(i); 
    
    info.col1.owner.position.add(info.normal);
    info.col2.owner.position.sub(info.normal);
  }
  collisions.clear();
}

void ResolveCollision(CollisionInfo collision){
    collision.col1.owner.velocity.sub(collision.normal);
    collision.col1.owner.Update();
    collision.col2.owner.velocity.add(collision.normal);
    collision.col2.owner.Update();
}


void keyReleased() {
   if (key == 'd' || key == 'D') {
     ToggleDebugMode();
   }
}


void ToggleDebugMode(){
  debugMode = !debugMode;
}
