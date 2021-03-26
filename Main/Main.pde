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
Object obj;

void setup() {
  size(512, 512, P3D);
  
  obj = new Object();
  obj.AddMesh(loadShape("Resources/Pyramid.obj"));
  obj.AddCollider(new Collider(obj));
  
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
}

void draw() {
  background(0);
  lights();
  
  obj.Update();
  obj.Draw();
}
