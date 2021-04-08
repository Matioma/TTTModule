class Space{
    PVector position;
    float sizeX;
    float sizeY;
    float sizeZ;

    Space parent;
    ArrayList<Space> subSpaces = new ArrayList();


    ArrayList<Object> objectsInSpace = new ArrayList();

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
        println("Draw the box",sizeX,sizeY,sizeZ);
        pushMatrix();
            translate(position.x,position.y,position.z);
            noFill();
            stroke(0,127,0);
            box(sizeX,sizeY,sizeZ);
        popMatrix();
    }
    
    
    
    boolean isBoxInSpace(BoxCollider collider){
        PVector colliderPos = collider.owner.position.copy();

        PVector differenceVector = colliderPos.sub(position);



        //PVector colliderPos1 = owner.position.copy();
        //PVector colliderPos2 = col.owner.position.copy();
        //PVector differenceVector= colliderPos2.sub(colliderPos1);
        
        // if(abs(differenceVector.x) >(XSize/2+collider2.XSize/2)) return null;
        // if(abs(differenceVector.y) >(YSize/2+collider2.YSize/2)) return null;
        // if(abs(differenceVector.z) >(ZSize/2+collider2.ZSize/2)) return null;


        return false;
    }



}