class Gear
{
  Body body;
  PolygonShape[] psArray;
  float size;
  
  Gear(float x, float y, float size_)
  {  
    psArray = new PolygonShape[32];
    size = size_;
    makeBody(new Vec2(x, y));
  }
  
  void makeBody(Vec2 center)
  {
    PVector[] points = new PVector[32];
   
    for(int i = 0; i < 32; i++)
    {
      float angle = i * 11.25;
      float x, y;
      if(i % 4 < 2)
      {
        x = (size * 0.7) * cos(radians(angle + 2));
        y = (size * 0.7) * sin(radians(angle + 2));
      }else
      {
        x = size * cos(radians(angle + 2));
        y = size * sin(radians(angle + 2));
      }
      points[i] = new PVector(x, y);
    }
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    
    for(int i = 0; i < 31; i++)
    {
      Vec2[] vertices = new Vec2[3];
      vertices[0] = box2d.vectorPixelsToWorld(new Vec2(points[i].x, points[i].y));
      vertices[1] = box2d.vectorPixelsToWorld(new Vec2(points[i+1].x, points[i+1].y));
      vertices[2] = box2d.vectorPixelsToWorld(new Vec2(0, 0));
    
      psArray[i] = new PolygonShape();
      psArray[i].set(vertices, vertices.length);
   
      body.createFixture(psArray[i], 1.0);
    }
        
    Vec2[] vertices = new Vec2[3];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(points[0].x, points[0].y));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(points[31].x, points[31].y));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(0, 0));
  
    psArray[31] = new PolygonShape();
    psArray[31].set(vertices, vertices.length);
 
    body.createFixture(psArray[31], 1.0);
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
   
    pushMatrix();
    translate(pos.x, pos.y); //<>//
    rotate(-a);
    fill(128);
    stroke(128);
    strokeWeight(2);
    for(PolygonShape ps : psArray)
    {
      beginShape();
      for (int i = 0; i < ps.getVertexCount(); i++) {
        Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
    
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, size * 0.8, size * 0.8);
    
    popMatrix();
  }
  
  boolean isDead() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.x < 0 || pos.x > width + size || pos.y > height + size) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }
}