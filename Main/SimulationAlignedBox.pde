class SimulationAlignedBox extends Simulation{
    void AddObjectToScene(PVector position){
        Object obj = new Object();
        obj.AddMesh(loadShape("Resources/Cube.obj"));
        //obj.AddMesh(loadShape("Resources/Sphere.obj"));
        // obj.AddMesh(loadShape("Resources/Pyramid.obj"));
       
        obj.AddCollider(new BoxCollider(obj));
        obj.SetPosition(position);
        objects.add(obj);
    }
}