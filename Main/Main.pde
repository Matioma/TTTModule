ArrayList<Entity> entities = new ArrayList<Entity>();

PShape usedShape;


static boolean debugMode=true;
void setup() {
  size(640, 360, P3D);
  
  //usedShape =loadShape("Resources/newscene/PyramidCut.obj");
  Mesh usedMesh = new Mesh(loadShape("Resources/newscene/PyramidCut.obj"));
  Collider collider = new Collider();
  
  entities.add(new Entity(usedMesh,collider));  
}

void draw() {
  background(100);
  for(int i =0; i< entities.size(); i++){
    entities.get(i).Update();
    entities.get(i).Draw();
  }  
}



void keyReleased() {
   if (key == 'd' || key == 'D') {
     ToggleDebugMode();
   }
}


void ToggleDebugMode(){
  debugMode = !debugMode;
}
