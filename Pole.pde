class Pole
{
  Body body;
  
  float x, y;
  float w, h;
  
  Pole(float x_, float y_)
  {
    x = x_;
    y = y_;
    w = 10;
    h = 10;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w / 2);
    float box2dH = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2dW,box2dH);
    
    body.createFixture(ps, 1.0);
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(128);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}