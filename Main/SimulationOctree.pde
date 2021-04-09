class SimulationOctreeSat extends Simulation{
    Space spaceTreeRoot;
    float spaceSizeX =200;
    float spaceSizeY =200;
    float spaceSizeZ =200;

    int depth=0;

    SimulationOctreeSat(){
        super();
    }


    SimulationOctreeSat(int depth){
        super();
        this.depth = depth;
        //spaceTreeRoot = GetTheSpace();
    }

    


    //Get the space bounding all the meshes
    Space GetTheSpace(){
        return new Space(new PVector(),spaceSizeX,spaceSizeY,spaceSizeZ,depth);
    }




    public void Update(){
        spaceTreeRoot = GetTheSpace();
        super.Update();
        spaceTreeRoot.Draw();
    }


    void DetectCollision(){
        ArrayList<Space> leefSpaces = spaceTreeRoot.getLeafNodes();
        // println(leefSpaces.size(),leefSpaces.get(0).objectsInSpace.size());

        println(leefSpaces.size());

        for( Space space:leefSpaces){
            for(int i=0; i<space.objectsInSpace.size();i++){
                for(int j=i+1; j<space.objectsInSpace.size();j++){
                    CollisionInfo colInfo =collisionDetectionMethod(space.objectsInSpace.get(i),space.objectsInSpace.get(j));
                    if(colInfo!=null){
                        ResolveCollision(colInfo);
                    }
                }
            }
        }


        // for(int i=0; i< objects.size()-1;i++){
        //     for(int j=i+1; j<objects.size(); j++){
        //         CollisionInfo colInfo =collisionDetectionMethod(objects.get(i),objects.get(j));
        //         if(colInfo!=null){
        //         ResolveCollision(colInfo);
        //         }
        //     }
        // }
    }


    void AddObjectToScene(PVector position){

      Object obj = new Object();
      obj.AddMesh(loadShape("Resources/Cube.obj"));
      
      obj.AddNewCollider(new BoxCollider(obj));
      obj.AddNewCollider(new ColliderSat(obj));
      obj.SetPosition(position);
      objects.add(obj);
    }


    CollisionInfo  collisionDetectionMethod(Object firstObject, Object secondObject){
     
        // BoxCollider box= (BoxCollider)firstObject.getCollider(CollidersTypes.Box);
        // BoxCollider box2 = (BoxCollider)secondObject.getCollider(CollidersTypes.Box);

        // if(box.checkCollision(box2) ==null) return null;

        ColliderSat sat1 =(ColliderSat)firstObject.getCollider(CollidersTypes.Sat);
        ColliderSat sat2 =(ColliderSat)secondObject.getCollider(CollidersTypes.Sat);


        return sat1.checkCollision(sat2);
    }

}