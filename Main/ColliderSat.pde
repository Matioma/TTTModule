class ColliderConvex extends Collider{
    PShape mesh;

    ColliderConvex(Object owner){
        super(owner);
        // BoundingBox boundingBox = getBoundingBox(owner.getMesh());
     
    }
  

    void Draw(){
        


    }

    CollisionInfo checkCollision(Collider col){
        
        return null;
    }
}