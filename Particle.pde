class Particle 
{
  Body body;
  float size;
  color bodyColor;
  
  int history_index;
  Vec2[] history;

  Particle(float x_, float y_) {
    size = 10;
    history_index = 0;
    history = new Vec2[25];
    for(int i = 0; i < history.length; i++)
    {
      history[i] = new Vec2(x_, y_);
    }
    bodyColor = color(random(128, 255), random(128, 255), random(128, 255));
    makeBody(new Vec2(x_, y_));
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size);
    cs.setRadius(box2dSize / 2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.5;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

  boolean isDead() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.x + size < 0 || pos.x > width + 200 || pos.y > height + size) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }

  void display() 
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(bodyColor, 128);
    noStroke();
    translate(pos.x, pos.y);
    rotate(-a);
    ellipse(0, 0, size, size);
    popMatrix();
    
    for(int i = history.length -1; i > 0; i--)
    {
      history[i] = history[i-1].clone();
    }
    history[0] = pos;
    
    for(int i = 0; i < history.length - 1; i++)
    {
      stroke(bodyColor, 128 - i * 5);
      strokeWeight(3);
      line(history[i].x, history[i].y, history[i + 1].x, history[i + 1].y);
    }
  }
}