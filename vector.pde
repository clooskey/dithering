class Vector {
  float x = 0;
  float y = 0;
  float z = 0;
  Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  void add(Vector a){
    this.x += a.x;
    this.y += a.y;
    this.z += a.z;
  }
  void mult(Vector a){
    this.x *= a.x;
    this.y *= a.y;
    this.z *= a.z;
  }
  
  void sub(Vector a){
    this.x -= a.x;
    this.y -= a.y;
    this.z -= a.z;
  }
  
  void divide(float a){
    this.x /= a;
    this.y /= a;
    this.z /= a;
  }
  
  void clip() {
    this.x = (this.x < 1) ? 0 : this.x;
    this.y = (this.y < 1) ? 0 : this.y;
    this.z = (this.z < 1) ? 0 : this.z;
  }
}