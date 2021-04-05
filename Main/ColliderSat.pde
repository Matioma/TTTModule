class ColliderSat extends Collider{
    PShape mesh;

    ColliderSat(Object owner){
        super(owner);
    }
    

    void Draw(){
        //this.owner.ProcessVertexData(new processPolygons())
        owner.ProcessVertexData(new PrintNormals());
    }

    CollisionInfo checkCollision(Collider col){
        
        return null;
    }
}