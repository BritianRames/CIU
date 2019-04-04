class Punto{

  float x;
  float y;
  float z;
  
  Punto(float x,float y,float z){
    print("paso1\n");
    this.x = x;
    this.y = y;
    this.z = z;
    print("paso2\n");
  }
  
  float getX(){
    return this.x;
  }
  
  float getY(){
    return this.y;
  }
  
  float getZ(){
    return this.z;
  }

}
