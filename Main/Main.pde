import peasy.*;

PeasyCam cam;

ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<CollisionInfo> collisions = new ArrayList<CollisionInfo>();

static boolean debugMode=false;
static boolean seeMeshes =true;

static int collisionsCount =0;


final int numberOfObjects =1000;

final int widthArea=100;
final int heightArea=100;
final int depthArea=100;

long MemoryUsed=0;

float lastTime;
float currentTime=0;
float deltaTime =0;

private static final long MEGABYTE = 1024L * 1024L;
public static double bytesToMegabytes(long bytes) {
  return (double)bytes / MEGABYTE;
}


void setup() {
  size(512, 512, P3D);
  
  
  //long before = Runtime.getRuntime().freeMemory();
 
  for(int i=0; i< numberOfObjects; i++){
      float x = random(-widthArea/2,widthArea/2);
      float y = random(-heightArea/2,heightArea/2);
      float z = random(-depthArea/2,depthArea/2);
     AddObjectToScene(new PVector(x,y,z));
  }
  
  Runtime runtime = Runtime.getRuntime();
  runtime.gc();
 
  MemoryUsed = runtime.totalMemory() - runtime.freeMemory();
  
  
  //println(Runtime.getRuntime().freeMemory());
  //MemoryUsed = before - Runtime.getRuntime().freeMemory();
  
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
  
  lastTime=millis();
}

void draw() {
  background(0);
  lights();
  DetectCollision();
  
  for(int i=0; i< objects.size();i++){
    objects.get(i).Update();
    objects.get(i).Draw();
  }
  
  DrawHud();
  
  
  
  deltaTime = millis()-lastTime;
  lastTime = millis();
   collisionsCount=0;
}


void DrawHud(){
  cam.beginHUD();
  textSize(32);
  
  String fps = String.format("%.2f", 1/(deltaTime/1000));
  text("FPS: "+ fps , 10, 30); 
  text("Collision Count: "+ collisionsCount , 10, 60); 
  
  textSize(16);
  String strDouble = String.format("%.2f", bytesToMegabytes(MemoryUsed));
  text("Memory used on the objects+Collider: "+strDouble  + " MB" , 10, 90); 
  cam.endHUD();
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
      
       //PVector colliderPos1 = objects.get(i).position.copy();
       //PVector colliderPos2 = objects.get(j).position.copy();
       
       //PVector differenceVector= colliderPos2.sub(colliderPos1);
       //float collider1Radius = objects.get(i).collider.radius;
       //float collider2Radius = objects.get(j).collider.radius;
       
       //if(differenceVector.mag()<= collider1Radius+collider2Radius){
       //  //println(differenceVector.mag() + ":" + collider1Radius+collider2Radius);
         
       //  collisionsCount++;
       //  differenceVector.normalize().mult(1);
       //  ResolveCollision(new CollisionInfo(differenceVector,objects.get(i).collider,objects.get(j).collider));
       //  //ResolveCollision(differenceVector,objects.get(i).collider,objects.get(j).collider);
       //}
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
