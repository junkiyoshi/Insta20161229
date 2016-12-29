import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Windmill> windmilles;
ArrayList<Particle> particles;
Floor floor;

void setup()
{
  size(1080, 1080);
  smooth();
  frameRate(60);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);

  windmilles = new ArrayList<Windmill>();
  for(int x = 0; x < 5; x++)
  {
    for(int y = 1; y < 5; y++)
    {
      if((x + y) % 2 == 0)
      {
        Windmill windmill = new Windmill(120 + x * 210, y * 210, 1);
        windmilles.add(windmill);
      }else
      {
        Windmill windmill = new Windmill(120 + x * 210, y * 210, -1);
        windmilles.add(windmill);
      }
    }
  }
  
  particles = new ArrayList<Particle>();
  //floor = new Floor();
}

void draw()
{
  background(0);
  box2d.step();
  
  /*
  floor.display();
  for(Windmill w : windmilles)
  {
    w.display();
  }
  */
  
  if(frameCount % 5 == 0)
  {
    Particle p = new Particle(0, height / 2);
    p.body.setLinearVelocity(new Vec2(30, 0));
    particles.add(p);
    p = new Particle(0, 130);
    p.body.setLinearVelocity(new Vec2(-30, 0));
    particles.add(p);
    p = new Particle(width - 10, height / 2 - 210);
    p.body.setLinearVelocity(new Vec2(-30, 0));
    particles.add(p);
    p = new Particle(width - 10, height / 2 + 210);
    p.body.setLinearVelocity(new Vec2(-30, 0));
    particles.add(p);
  }
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle particle = it.next();
    particle.display();
    
    if(particle.isDead())
    {
      it.remove();
    }
  }
  
  println(frameCount);
  /*
  saveFrame("screen-#####.png");
  if(frameCount > 3600)
  {
     exit();
  }
  */
}

void mouseClicked()
{
  Particle p = new Particle(0, height / 2);
  p.body.setLinearVelocity(new Vec2(30, 0));
  particles.add(p);
  p = new Particle(width - 10, height / 2 - 210);
  p.body.setLinearVelocity(new Vec2(-30, 0));
  particles.add(p);
}