class Particle {
  PVector position;
  float radius, mass = 1, damping;
  int c;
  PVector speed, acceleration, force;


  Particle(float start_x, float start_y, int r, int col) {
    this.position = new PVector(start_x, start_y);
    this.radius = r;
    this.c = col;
    speed = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    force = new PVector(0, 0);
    damping = 100;
  }

  void physics() {
    this.speed.add(this.acceleration);
    this.position.add(this.speed);
    this.acceleration.mult(0);
    if (this.speed.mag() < 1) {
      this.speed.x = (this.speed.x > 1) ? this.speed.x : 0;
      this.speed.y = (this.speed.y > 1) ? this.speed.y : 0;
      this.speed.z = (this.speed.z > 1) ? this.speed.z : 0;
    }
    this.resist();
  }

  void apply(PVector f) {
    f.div(this.mass);
    this.acceleration.add(f);
  }

  void resist() {
    PVector t = this.speed.copy();
    t.rotate(PI);
    t.setMag(1);
    this.apply(t);
  }

  void show(boolean colored) {
    fill(colored ? this.c : 255);
    float rad = this.radius * colorMap(this.c);
    ellipse(this.position.x, this.position.y, rad, rad);
  }
}


float colorMap(color c) {
  return map(red(c)+green(c)+blue(c), 0, 256*3, 0.125, 1);
}