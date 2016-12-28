class Windmill
{
  RevoluteJoint joint;
  Gear gear;
  Pole pole;
  
  Windmill(float x_, float y_, int direction)
  {
    gear = new Gear(x_, y_, 100);
    pole = new Pole(x_, y_);
    
    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(pole.body, gear.body, gear.body.getWorldCenter());
    
    rjd.motorSpeed = PI * 2 * direction;
    rjd.maxMotorTorque = 1000000.0;
    rjd.enableMotor = true;
       
    joint = (RevoluteJoint)box2d.world.createJoint(rjd);
  }
  
  void display()
  {
    gear.display();
    // pole.display();
  }
}