class SimulationOctreeSat extends SimulationOctree{
    SimulationOctreeBoxSat(int depth){
        super(depth);
    }

    void AddObjectToScene(PVector position){
        Object obj = new Object();
        obj.AddMesh(simulationShape);
        
        obj.AddNewCollider(new BoxCollider(obj));
        obj.AddNewCollider(new ColliderSat(obj));
        obj.SetPosition(position);
        objects.add(obj);
    }

    CollisionInfo  collisionDetectionMethod(Object firstObject, Object secondObject){
        ColliderSat sat1 =(ColliderSat)firstObject.getCollider(CollidersTypes.Sat);
        ColliderSat sat2 =(ColliderSat)secondObject.getCollider(CollidersTypes.Sat);


        return sat1.checkCollision(sat2);
    }
}