import peasy.*;


PeasyCam cam;

static boolean debugMode=false;
static boolean seeMeshes =true;
static boolean showVerticies = false;


ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<CollisionInfo> collisions = new ArrayList<CollisionInfo>();
static int collisionsCount =0;



float lastTime;
float deltaTime =0;
long memoryUsed=0;

private static final long MEGABYTE = 1024L * 1024L;
public static double bytesToMegabytes(long bytes) {
  return (double)bytes / MEGABYTE;
}

Simulation simulation;

void setup() {
  size(512, 512, P3D);
  
  simulation  = new SimulationSphere();

  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
  
  lastTime=millis();
}

void draw() {
  background(0);
  lights();
  
  simulation.Update();
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
  String strDouble = String.format("%.2f", bytesToMegabytes(memoryUsed));
  text("Memory used: "+strDouble  + " MB" , 10, 90); 
  cam.endHUD();
}
