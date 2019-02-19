ArrayList <Punto> puntos ;
ArrayList <Punto> puntos3D ;
PShape obj ;
boolean firstTime = true;
int estado = 0;

float angulograd = 10; //1,2,3,4,5,6,8,9,10,12,15,18,20,24,30,36,40-----60,72,90,120
int numPuntos = int(360/angulograd);

void setup(){
  size(1400,800,P3D);
  //La variable
  puntos = new ArrayList<Punto>();
  puntos3D = new ArrayList<Punto>();
  
}

void draw(){
  if(estado == 0){
    
    background(255);
    line(700,0,700,800);
    fill(0,0,0);
    textFont(createFont("Geogia",24));
    textAlign(CENTER,CENTER);
    text("DRAW LINES IN THIS SECTION. \nPRESS (MAYUS+R) FOR 3D", 1050,60);
    
    if(mousePressed == true){
      if(mouseX > 699){
        puntos.add(new Punto(mouseX-700,mouseY-400,0));
      }
      print(puntos.size());
      delay(500);
    }
    
    for(int i= 0; i<puntos.size(); i++){
      Punto primero = puntos.get(i);
      Punto segundo; 
      try{
        segundo = puntos.get(i+1);
      }catch(Exception e){
        segundo = new Punto(mouseX-700,mouseY-400,0);
      }
      line(primero.getX()+700,primero.getY()+400,segundo.getX()+700,segundo.getY()+400);
    } 
    
  }
  
  if(estado == 1){
    
    obj=createShape();
  // El pincel
    obj.beginShape(TRIANGLE_STRIP);
    obj.fill(102);
    obj.stroke(255);
    obj.strokeWeight(2);
    // Puntos de la forma
    for(Punto punto : puntos){
      mifuncion(punto);
    }
    
    //mifuncion();
    
    Punto uno;
    Punto dos;
    int fin_meridiano = numPuntos-1;
    int limite = fin_meridiano;
    print(fin_meridiano,"\n");
    
    for (int i = 0; i<puntos3D.size(); i++){
      
      
      
      uno = puntos3D.get(i);
      
      
      try{
        dos = puntos3D.get(i+numPuntos);
        //print(i ,"-", i+4, "   \n");
      } catch (Exception e){
        break;
      }
      
      obj.vertex(uno.getX(),uno.getY(),uno.getZ());
      obj.vertex(dos.getX(),dos.getY(),dos.getZ());
      print(i ,"-", i+4, "   \n");
      
      if(i == fin_meridiano){
        uno = puntos3D.get(i-limite);
        dos = puntos3D.get(i+1);
        obj.vertex(uno.getX(),uno.getY(),uno.getZ());
        obj.vertex(dos.getX(),dos.getY(),dos.getZ());
        print("ENTRO   ",i-limite ,"-", i+1, "   \n");
        fin_meridiano = fin_meridiano +numPuntos;
      }
    }
    
    obj.endShape();
    estado = 2;
  }
  
  
  
  if(estado == 2){
    background(255);
    fill(0,0,0);
    textFont(createFont("Geogia",24));
    textAlign(CENTER,CENTER);
    text("PRESS (MAYUS+Q) FOR UNDO.", 700,750);
    //Movemos con puntero
    translate(mouseX, mouseY);
    //Muestra la forma
    shape(obj);
    
    for(Punto punto : puntos3D){
      stroke(255,0,0);
      strokeWeight(10);
      point(punto.getX(),punto.getY(),punto.getZ());
      //print("X = ", punto.getX(),"   Y = ", punto.getY(),"   Z = ", punto.getZ(),"\n");
    }
  }
  
  
}



void keyPressed(){
  if(key == 'R' && estado == 0){
    estado = 1;
  }
  if(key == 'Q' && estado == 2){
    estado = 0;
    puntos = new ArrayList<Punto>();
    puntos3D = new ArrayList<Punto>();
    stroke(0,0,0);
    strokeWeight(1);
  }
}

void mifuncion(Punto punto){
  float x = punto.getX();
  float y = punto.getY();
  float z = punto.getZ();
  float xx = x;
  //float angulo = (20*3.14159265359)/180;
  float angulorad = (radians(angulograd));
  puntos3D.add(new Punto(x,y,z));
  //obj.vertex(x,y,z);
  for(int i = 0; i < (360/angulograd)-1; i++){
    x = xx * cos(angulorad) - z * sin(angulorad);
    z = xx * sin(angulorad) + z * cos(angulorad);
    xx = x;
    //print("X = ", px, "   Z = ", py,"\n");
    //print("--------(",cos((90*3.14159265359)/180),"--------");
    //print("--------(",x*sin((90*3.14159265359)/180),"--------");
    //obj.vertex(x,y,z);
    puntos3D.add(new Punto(x,y,z));
    
  }

}
