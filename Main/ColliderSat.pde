class ColliderSat extends Collider{
    PShape mesh;

    ColliderSat(Object owner){
        super(owner);
        mesh = owner.getMesh();
    }
    

    void Draw(){
        //this.owner.ProcessVertexData(new processPolygons())
        //owner.ProcessVertexData(new PrintNormals());
    }

    CollisionInfo checkCollision(Collider col){
        
        if(col instanceof ColliderSat){
            PVector colliderPos1 = owner.position.copy();   
            PVector colliderPos2 = col.owner.position.copy();      
            PVector differenceVector= colliderPos2.sub(colliderPos1);

            ArrayList<PVector> normals = owner.getNormals();
            for(int i=0; i<normals.size(); i++){
                float projectedDifference = differenceVector.dot(normals.get(i));
                
                //First mesh range calculation
                float maxProjection = biggestProjection(owner,normals.get(i));
                //Second mesh range calculation
                float minProjection =smallestProjection(col.owner,normals.get(i));
                
                if(projectedDifference - abs(maxProjection) - abs(minProjection) >0){
                    return null;
                }
            }
            
            ArrayList<PVector> normalsOther = owner.getNormals();
            for(int i=0; i<normalsOther.size(); i++){
                float projectedDifference = differenceVector.dot(normalsOther.get(i));
                
                //First mesh range calculation
                float maxProjection = biggestProjection(col.owner,normalsOther.get(i));
                //Second mesh range calculation
                float minProjection =smallestProjection(owner,normalsOther.get(i));
                
                if(projectedDifference - abs(maxProjection) - abs(minProjection) >0){
                    return null;
                }
            }
        }
        collisionsCount++;
        return sparationColisionInfo(this,col);
    }


    boolean checkSatCollision(ArrayList<PVector> normals, ColliderSat normalOwner, ColliderSat other){
        PVector colliderPos1 =normalOwner.owner.position.copy();   
        PVector colliderPos2 = other.owner.position.copy();      
        PVector differenceVector= colliderPos2.sub(colliderPos1);

        for(int i=0; i<normals.size(); i++){
            float projectedDifference = differenceVector.dot(normals.get(i));


        }
        return false;
    }

    float biggestProjection(Object objRef, PVector normal){
        float maxProjection =0;

        PShape mesh = objRef.getMesh();

        for(int i=0; i< mesh.getChildCount(); i++){
            PShape polygon = mesh.getChild(i);

            for( int j = 0; j<polygon.getVertexCount(); j++){
                PMatrix3D matrix = objRef.GetMatrix();

                PVector globalVertexPos = new PVector(); 
                matrix.mult(polygon.getVertex(j).copy(),globalVertexPos);

                PVector rangeVector = globalVertexPos.copy().sub(objRef.position);
                float projectedValue = rangeVector.dot(normal);
                if(projectedValue>maxProjection) maxProjection = projectedValue;
            }
        }
        return maxProjection;
    }

    float smallestProjection(Object objRef, PVector normal){
        float maxProjection =0;

        PShape mesh = objRef.getMesh();

        for(int i=0; i< mesh.getChildCount(); i++){
            PShape polygon = mesh.getChild(i);

            for( int j = 0; j<polygon.getVertexCount(); j++){
                PMatrix3D matrix = objRef.GetMatrix();

                PVector globalVertexPos = new PVector(); 
                matrix.mult(polygon.getVertex(j).copy(),globalVertexPos);

                PVector rangeVector = globalVertexPos.copy().sub(objRef.position);
                float projectedValue = rangeVector.dot(normal);
                if(projectedValue<maxProjection) maxProjection = projectedValue;
            }
        }
        return maxProjection;
    }


    



    CollisionInfo sparationColisionInfo(Collider col1, Collider col2){
        PVector colliderPos1 = col1.owner.position.copy();
        PVector colliderPos2 = col2.owner.position.copy();      
        PVector differenceVector= colliderPos2.sub(colliderPos1);

        differenceVector.normalize();
        return new CollisionInfo(differenceVector,col1,col2);
    }

    boolean projectionsOverlap(){
        return false;
    }

}