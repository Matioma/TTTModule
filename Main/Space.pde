class Space{
    int depth=2;
    

    PVector position;
    float sizeX;
    float sizeY;
    float sizeZ;

    Space parent;
    ArrayList<Space> subSpaces = new ArrayList();


    ArrayList<Object> objectsInSpace = new ArrayList();

    //Creating the root space
    Space(PVector pPosition, float pSizeX, float pSizeY, float pSizeZ, int pDepth){
        position =pPosition;
        sizeX = pSizeX;
        sizeY = pSizeY;
        sizeZ = pSizeZ;
        depth = pDepth;
        FindObjectsInSpace();
        Split(depth);
    }
    //Creating a subspace
    Space(PVector pPosition, float pSizeX, float pSizeY, float pSizeZ,Space pParent){
        position =pPosition;
        sizeX = pSizeX;
        sizeY = pSizeY;
        sizeZ = pSizeZ;
        parent =pParent;
        FindObjectsInSpace();
    
    }

    void Split(int number){
        if(number==0) return;

        PVector minVector = position.copy().sub(new PVector(sizeX/2, sizeY/2, sizeZ/2));
        PVector maxVector = position.copy().sub(new PVector(sizeX/2, sizeY/2, sizeZ/2));

        float subspaceXSize = sizeX/2;
        float subspaceYSize = sizeY/2;
        float subspaceZSize = sizeZ/2;

        //Bottom Squares
        PVector positionSubSpace1  = position.copy().add(new PVector(-sizeX/4, -sizeY/4, -sizeZ/4));
        Space subSpace1 = new Space(positionSubSpace1,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace1);
        PVector positionSubSpace6 = position.copy().add(new PVector(-sizeX/4, -sizeY/4, sizeZ/4));
        Space subSpace6 = new Space(positionSubSpace6,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace6);
        PVector positionSubSpace7 = position.copy().add(new PVector(sizeX/4, -sizeY/4, sizeZ/4));
        Space subSpace7 = new Space(positionSubSpace7,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace7);
        PVector positionSubSpace8 = position.copy().add(new PVector(sizeX/4, -sizeY/4, -sizeZ/4));
        Space subSpace8 = new Space(positionSubSpace8,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace8);

        //Top Squares
        PVector positionSubSpace2  = position.copy().add(new PVector(sizeX/4, sizeY/4, sizeZ/4));
        Space subSpace2= new Space(positionSubSpace2,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace2);
        PVector positionSubSpace3  = position.copy().add(new PVector(sizeX/4, sizeY/4, -sizeZ/4));
        Space subSpace3= new Space(positionSubSpace3,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace3);
        PVector positionSubSpace4  = position.copy().add(new PVector(-sizeX/4, sizeY/4, -sizeZ/4));
        Space subSpace4= new Space(positionSubSpace4,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace4);
        PVector positionSubSpace5  = position.copy().add(new PVector(-sizeX/4, sizeY/4, sizeZ/4));
        Space subSpace5= new Space(positionSubSpace5,subspaceXSize,subspaceYSize,subspaceZSize, this);
        subSpaces.add(subSpace5);
        

        for(Space space: subSpaces){
            space.Split(number-1);
        }
    }


    ArrayList<Space> getLeafNodes(){
        ArrayList<Space> nodes = new ArrayList();
        if(subSpaces.size()==0){
            nodes.add(this);
            return nodes;
        }

        for(Space space: subSpaces){
            nodes.addAll(space.getLeafNodes());
        }
        return nodes;
    }


    

    void Draw(){
        if(!debugMode) return;
        if(subSpaces.size()>0) {
            for(Space s: subSpaces){
                s.Draw();
            }
            return;
        }
        pushMatrix();
            translate(position.x,position.y,position.z);
            noFill();
            stroke(0,127,0);
            box(sizeX,sizeY,sizeZ);
        popMatrix();
    }
    
    void FindObjectsInSpace(){
        if(parent ==null){
            for(int i=0; i< objects.size();i++){
                BoxCollider col = (BoxCollider)objects.get(i).getCollider(CollidersTypes.Box);
                if(isBoxInSpace(col)){
                    objectsInSpace.add(col.owner);
                }
            }
        }
        if(parent !=null){
            for(int i=0; i< parent.objectsInSpace.size(); i++){
                BoxCollider col = (BoxCollider)parent.objectsInSpace.get(i).getCollider(CollidersTypes.Box);
                if(isBoxInSpace(col)){
                    objectsInSpace.add(col.owner);
                }
            }
        }
    }

    
    
    boolean isBoxInSpace(BoxCollider collider){
        PVector colliderPos = collider.owner.position.copy();
        PVector differenceVector = colliderPos.sub(position);
        if(abs(differenceVector.x) >(sizeX/2+collider.XSize/2)) return false;
        if(abs(differenceVector.y) >(sizeY/2+collider.YSize/2)) return false;
        if(abs(differenceVector.z) >(sizeZ/2+collider.ZSize/2)) return false;
        return true;
    }



}