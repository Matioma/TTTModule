class SimulationBoxSat extends Simulation{
    void AddObjectToScene(PVector position){

      Object obj = new Object();
      obj.AddMesh(loadShape("Resources/Cube.obj"));
      //obj.AddMesh(loadShape("Resources/Sphere.obj"));
      //obj.AddMesh(loadShape("Resources/Pyramid.obj"));
      
      //obj.AddCollider(new BoxCollider(obj));
      
      obj.AddNewCollider(new BoxCollider(obj));
      obj.AddNewCollider(new ColliderSat(obj));
      obj.SetPosition(position);
      objects.add(obj);
    }


    CollisionInfo  collisionDetectionMethod(Object firstObject, Object secondObject){
        BoxCollider box= (BoxCollider)firstObject.getCollider(CollidersTypes.Box);
        BoxCollider box2 = (BoxCollider)secondObject.getCollider(CollidersTypes.Box);


        if(box.checkCollision(box2) ==null) return null;

        ColliderSat sat1 =(ColliderSat)firstObject.getCollider(CollidersTypes.Sat);
        ColliderSat sat2 =(ColliderSat)secondObject.getCollider(CollidersTypes.Sat);
      

        return sat1.checkCollision(sat2);
        //return firstObject.collider.checkCollision(secondObject.collider);
    }

}