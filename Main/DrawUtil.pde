class DrawUtil{

    void DrawVector(PVector start, PVector end)
    {
        pushMatrix();
            translate(start.x,start.y,start.z);
            sphere(0.30);
        popMatrix();

        pushMatrix();
            translate(end.x,end.y,end.z);
            sphere(0.1);
        popMatrix();

        //Draw A vector
        beginShape(LINES);
            vertex(start.x,start.y,start.z);
            vertex(end.x,end.y,end.z);
        endShape();
    }


}