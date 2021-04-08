class Space{
    PVector position;
    float sizeX;
    float sizeY;
    float sizeZ;

    Space parent;
    ArrayList<Space> subSpaces = new ArrayList();


    ArrayList<Object> objectsInSpace = new ArrayList();

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


    Space(PVector pPosition, float pSizeX, float pSizeY, float pSizeZ){
        position =pPosition;
        sizeX = pSizeX;
        sizeY = pSizeY;
        sizeZ = pSizeZ;
       
    }

    void Draw(){
        if(!debugMode) return;
        if(subSpaces.size()>0) {
            for(Space s: subSpaces){
                s.Draw();
            }
            return;
        }
        println("WTF");
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