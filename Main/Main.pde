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
static boolean debugMode=true;
ArrayList<Object> objects = new ArrayList<Object>();


final int numberOfObjects =100;

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
