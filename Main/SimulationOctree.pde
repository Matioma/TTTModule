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
        PVector minVector = ((BoxCollider)objects.get(0).getCollider(CollidersTypes.Box)).getMin();
        PVector maxVector = ((BoxCollider)objects.get(0).getCollider(CollidersTypes.Box)).getMax();

        for(int i =1; i<objects.size(); i++){
            BoxCollider boxCollider =(BoxCollider)objects.get(i).getCollider(CollidersTypes.Box);

            println(boxCollider.owner.getPosition());
            
            PVector objMinVector = boxCollider.getMin();
            PVector objMaxVector = boxCollider.getMax();

            println(boxCollider.owner.getPosition(), objMinVector, objMaxVector);


            if(objMinVector.x < minVector.x) minVector.x = objMinVector.x;
            if(objMinVector.y < minVector.y) minVector.y = objMinVector.y;
            if(objMinVector.z < minVector.z) minVector.z = objMinVector.z;
            

            if(objMaxVector.x > maxVector.x) maxVector.x = objMaxVector.x;
            if(objMaxVector.y > maxVector.y) maxVector.y = objMaxVector.y;
            if(objMaxVector.z > maxVector.z) maxVector.z = objMaxVector.z;
        }

        
        float spaceWidth =abs(maxVector.x-minVector.x);
        float spaceHeight=abs(maxVector.y-minVector.y);
        float spaceDepth=abs(maxVector.z-minVector.z);

        PVector spaceCenter = minVector.add(new PVector(spaceWidth/2,spaceHeight/2,spaceDepth/2));

        
        return new Space(spaceCenter,spaceWidth,spaceHeight,spaceDepth,depth);
        //return new Space(new PVector(),spaceSizeX,spaceSizeY,spaceSizeZ,depth);
    }




    public void Update(){
        spaceTreeRoot = GetTheSpace();
        super.Update();
        spaceTreeRoot.Draw();
    }


    void DetectCollision(){
        ArrayList<Space> leefSpaces = spaceTreeRoot.getLeafNodes();
       

        // println(leefSpaces.size());

        for( Space space:leefSpaces){
            // println(space.objectsInSpace.size());
            for(int i=0; i<space.objectsInSpace.size();i++){
                for(int j=i+1; j<space.objectsInSpace.size();j++){
                    CollisionInfo colInfo =collisionDetectionMethod(space.objectsInSpace.get(i),space.objectsInSpace.get(j));
                    if(colInfo!=null){
                        ResolveCollision(colInfo);
                    }
                }
            }
        }
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