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

            ArrayList<PVector> meshNormals1 = owner.getNormals();
            ArrayList<PVector> meshNormals2 = col.owner.getNormals();

            //Check first mesh normals
            for(int i=0;i< meshNormals1.size(); i++){
                 if(noOverlapOnNormal(meshNormals1.get(i),owner, col.owner,differenceVector)) return null;
            }
            //Check second mesh normals 
            for(int j=0; j<meshNormals2.size(); j++){
                if(noOverlapOnNormal(meshNormals2.get(j),col.owner, owner,differenceVector)) return null;
            }
            //Check cross product collisions
            for(int i=0;i< meshNormals1.size(); i++){
                for(int j=0; j<meshNormals2.size(); j++){
                    if(noOverlapOnNormal(meshNormals2.get(j).cross(meshNormals1.get(i)),col.owner, owner,differenceVector)) return null;
                }
            }
        }
        // collisionsCount++;
        return sparationColisionInfo(this,col);
    }



    boolean noOverlapOnNormal(PVector normal, Object owner, Object other, PVector differenceVector){
        float projectedDifference = differenceVector.dot(normal);
        
        float maxProjection = biggestProjection(owner,normal);
        float minProjection =smallestProjection(other,normal);

        if(projectedDifference - abs(maxProjection) - abs(minProjection) >0){
            return true;
        }
        return false;
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

    

}