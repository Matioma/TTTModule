
void keyReleased() {
   if (key == 'd' || key == 'D') {
     ToggleDebugMode();
   }
   if (key == 's' || key == 'S') {
     ToggleVisibleMesh();
   }
   if (key == 'a' || key == 'A') {
     ToggleShowVerticies();
   }
}

void ToggleDebugMode(){
  debugMode = !debugMode;
}
void ToggleVisibleMesh(){
  seeMeshes = !seeMeshes;
}
void ToggleShowVerticies(){
  showVerticies = !showVerticies;
}
