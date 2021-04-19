import peasy.*;


PeasyCam cam;

static boolean debugMode=false;
static boolean seeMeshes =true;
static boolean showVerticies = false;


ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<CollisionInfo> collisions = new ArrayList<CollisionInfo>();
static int collisionsCount =0;



PShape simulationShape ;


float lastTime;
float deltaTime =0;
long memoryUsed=0;

FloatList lastFrames = new FloatList();
int avarageFramesCount = 10;



private static final long MEGABYTE = 1024L * 1024L;
public static double bytesToMegabytes(long bytes) {
  return (double)bytes / MEGABYTE;
}

Simulation simulation;


float averaFrameMilis(){
  float s =0;
  for(int i=0; i<avarageFramesCount; i++){
    s+= lastFrames.get(i);
    
    // return s/avarageFramesCount;
  }
  return s/avarageFramesCount;
  //println(s/avarageFramesCount);
  // return 0;
}


void recordFps(float delta){
  lastFrames.append(delta);
  lastFrames.remove(0);
}

void setup() {
  size(1024, 1024, P3D );
  frameRate(240);
  simulationShape = loadShape("Resources/Cube.obj");
  
  simulation  = new SimulationSphere(); 

  for(int i=0;i<avarageFramesCount; i++){
    lastFrames.append(0);
  }
  
  //simulation = new SimulationAlignedBox();
  //simulation  = new SimulationBoxSat();

  //simulation = new SimulationOctreeSat(1);
  //simulation = new SimulationOctreeBoxSat(4);

 
 

  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(5000);
  
  lastTime=millis();
}

void draw() {
  background(0);
  lights();
  
  simulation.Update();
  DrawHud();
  
  deltaTime = millis()-lastTime;
 
  recordFps(deltaTime);
  lastTime = millis();
  collisionsCount=0;
}


void DrawHud(){
  cam.beginHUD();
  textSize(32);
  
  String fps = String.format("%.2f", 1/(averaFrameMilis()/1000));
  text("FPS: "+ fps , 10, 30); 
  text("Collision Count: "+ collisionsCount , 10, 60); 
  
  textSize(16);
  String strDouble = String.format("%.2f", bytesToMegabytes(memoryUsed));
  text("Memory used: "+strDouble  + " MB" , 10, 90); 
  cam.endHUD();
}
