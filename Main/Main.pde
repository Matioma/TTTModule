import peasy.*;

PeasyCam cam;

ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<CollisionInfo> collisions = new ArrayList<CollisionInfo>();

static boolean debugMode=false;
static boolean seeMeshes =true;

int collisionsCount =0;

final int numberOfObjects =500;

final int widthArea=10;
final int heightArea=10;
final int depthArea=10;



float lastTime;
float currentTime=0;
float deltaTime =0;

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
  
  
  lastTime=millis();
}

void draw() {
  
  background(0);
  cam.beginHUD();
  textSize(32);
  text("FPS: "+ 1/(deltaTime/1000) , 10, 30); 
  cam.endHUD();
  lights();
  
  DetectCollision();
  if(collisionsCount!=0){
      println(collisionsCount);
  }
  collisionsCount=0;
  

  for(int i=0; i< objects.size();i++){
    objects.get(i).Update();
    objects.get(i).Draw();
  }
  
  //currentTime = millis();
  deltaTime = millis()-lastTime;
  //textSize(32);
  //text("FPS: "+ 1/(deltaTime/1000) , 10, 30); 
  //println(deltaTime);
  lastTime = millis();
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
         
         collisionsCount++;
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
    collision.col1.owner.velocity.sub(collision.normal.mult(0.1));
    collision.col1.owner.Update();
    collision.col2.owner.velocity.add(collision.normal.mult(0.1));
    collision.col2.owner.Update();
}


void keyReleased() {
   if (key == 'd' || key == 'D') {
     ToggleDebugMode();
   }
   if (key == 's' || key == 'S') {
     ToggleVisibleMesh();
   }
}


void ToggleDebugMode(){
  debugMode = !debugMode;
}

void ToggleVisibleMesh(){
  seeMeshes = !seeMeshes;
}
