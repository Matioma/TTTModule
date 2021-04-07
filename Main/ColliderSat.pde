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
        ArrayList<PVector> normals = owner.getNormals();
        
        if(col instanceof ColliderSat){
            ColliderSat col2 = (ColliderSat)col; 

            for(int i=0; i<normals.size(); i++){
                PVector colliderPos1 = owner.position.copy();   
                PVector colliderPos2 = col.owner.position.copy();      
                PVector differenceVector= colliderPos2.sub(colliderPos1);
                float projectedDifference = differenceVector.dot(normals.get(i));

                //First mesh range calculation
                float maxProjection1 =0;
                for(int polygon=0; polygon< mesh.getChildCount(); polygon++){
                    for(int vertex=0; vertex<mesh.getChild(polygon).getVertexCount(); vertex++){
                        PMatrix3D matrix = owner.GetMatrix();

                        PVector globalVertexPos = new PVector(); 
                        matrix.mult(mesh.getChild(polygon).getVertex(vertex).copy(),globalVertexPos);
                        
                        PVector rangeVector = globalVertexPos.copy().sub(colliderPos1);
                        float projectedValue = rangeVector.dot(normals.get(i));
                        if(projectedValue>maxProjection1) maxProjection1 = projectedValue;
                    }
                }

                //Second mesh range calculation
                float minProjection2 =0;
                for(int polygon=0; polygon< col2.mesh.getChildCount(); polygon++){
                    for(int vertex=0; vertex< col2.mesh.getChild(polygon).getVertexCount(); vertex++){
                        PMatrix3D matrix = owner.GetMatrix();

                        PVector globalVertexPos = new PVector(); 
                        matrix.mult(mesh.getChild(polygon).getVertex(vertex).copy(),globalVertexPos);
                        
                        PVector rangeVector = globalVertexPos.copy().sub(colliderPos1);
                        float projectedValue = rangeVector.dot(normals.get(i));
                        if(projectedValue<minProjection2) minProjection2 = projectedValue;
                    }
                }
                
                if(projectedDifference - abs(maxProjection1) - abs(minProjection2) >0){
                    return null;
                }
            }
        }
        collisionsCount++;
        return sparationColisionInfo(this,col);
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