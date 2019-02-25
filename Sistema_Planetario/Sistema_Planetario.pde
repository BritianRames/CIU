
float ang;
float angS1, angS2, angS3, angS4, angS5;
PImage img,imgSol, imgMercurio, imgLatierra,imgVenus, imgLuna, imgMarte, imgJupiter;
PShape galaxy, sun, mercurio, venus, tierra, marte, jupiter, luna, nave;
int x,y,z;
boolean inicial = true;

void setup(){
  //frameRate(1000);
  
  x = 0;
  y = -150;
  z = 0;
  
  size (1400 ,800 ,P3D);
  stroke(0);
  ang = 0;
  angS1 = 0;
  angS2 = 0;
  angS3 = 0;
  angS4 = 0;
  angS5 = 0;
  
  imageMode (CENTER) ;
  //Carga de l a imagen
  img=loadImage("Fondo_galaxia.jpg" ) ;
  img.resize(1400,800);
  imgSol=loadImage("Sol.png" ) ;
  imgMercurio=loadImage("Mercurio.jpg" ) ;
  imgLatierra=loadImage("Latierra.jpg" ) ;
  imgVenus=loadImage("Venus.png" ) ;
  imgLuna=loadImage("Luna.jpg" ) ;
  imgMarte=loadImage("Marte.jpg" ) ;
  imgJupiter=loadImage("Jupiter.jpeg" ) ;
  
  noStroke();
  
  sun = createShape(SPHERE, 100);
  sun.setTexture(imgSol);
  mercurio = createShape(SPHERE, 5);
  mercurio.setTexture(imgMercurio);
  tierra = createShape(SPHERE, 10);
  tierra.setTexture(imgLatierra);
  venus = createShape(SPHERE, 15);
  venus.setTexture(imgVenus);
  marte = createShape(SPHERE, 20);
  marte.setTexture(imgMarte);
  jupiter = createShape(SPHERE, 25);
  jupiter.setTexture(imgJupiter);
  luna = createShape(SPHERE, 5);
  luna.setTexture(imgLuna);
  //nave = loadShape("retro_rocket.obj");
  //nave.scale(0.1);
  nave = createShape(SPHERE, 15);
  nave.setTexture(imgMarte);
  
  textFont(createFont("Geogia",30));
  
  
}

void preSet(){
  background(img);
  
  translate(width/2,height/2-200,-200);
  
 
  noStroke();
  //shape(galaxy);
  
  
  
  pushMatrix();
  rotateX(PI/4);
  
  
  noFill();
  strokeWeight(1);
  stroke(255,255,255);
  ellipse(0,0,(width*2)*0.10,(width*2)*0.10);
  ellipse(0,0,(width*2)*0.15,(width*2)*0.15);
  ellipse(0,0,(width*2)*0.25,(width*2)*0.25);
  ellipse(0,0,(width*2)*0.35,(width*2)*0.35);
  ellipse(0,0,(width*2)*0.45,(width*2)*0.45);
  
  popMatrix();
}

void draw(){
  
  
  
  if(keyPressed){
    
    inicial = false;
    switch(key) {
      case 'w': 
        y = y - 10;
        break;
      case 's': 
        y = y + 10;
        break;
      case 'a': 
        x = x - 10;
        break;
      case 'd': 
        x = x + 10;
        break;
      case 'k': 
        z = z - 10;
        break;
      case 'm': 
        z = z + 10;
        break;
    }
    
  }
  
  preSet();
  //pushMatrix();
  //camera (x,y,z,0,100,0,0,1,0) ;
  //popMatrix();
  fill(255,255,255);
  //textFont(createFont("Geogia",30));
  textAlign(CENTER,CENTER);
  String s = "(x = "+str(x)+" ) (y = "+ str(y) +" ) (z = "+str(z)+" )";
  text(s,width/2-100,height/2+100);
  text("(W) or (S) = X axis",width/2-100,height/2+150);
  text("(A) or (D) = Y axis",width/2-100,height/2+200);
  text("(K) or (M) = Z axis",width/2-100,height/2+250);
  
  rotateX(radians(-45));
  
  if(inicial){
    fill(255,0,0);
    noStroke();
    triangle(10,-150, 95, -150, 90, -170);
    
    strokeWeight(10);
    stroke(255,0,0);
    line(90, -160, 300, -180); 
    strokeWeight(1);
    
    fill(255,0,0);
    //textFont(createFont("Geogia",50));
    textAlign(CENTER,CENTER);
    text("HERE", 370,-180);
    
    
  }
  
  pushMatrix();
  translate(x,y,z);
  rotateX(radians(180));
  shape(nave);
  popMatrix();
  
  
  
  pushMatrix();
  
  fill(255,255,255);
  //textFont(createFont("Geogia",30));
  textAlign(CENTER,CENTER);
  text("ESTRELLA", 0,-130);
  rotateY(radians(ang));
  fill(243,159,24);
  //sphere(50);
  shape(sun);
  popMatrix();

  ang = ang+0.25;
  if(ang>=360){
    ang = 0;
  }
  
  pushMatrix();
  rotateY(radians(angS5));
  translate(-width*0.10,0,0);
  rotateY(radians(angS5));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("ALPHA", 0,-90);
  fill(203,129,11);
  //sphere(20);
  shape(mercurio);
  popMatrix();
  
  angS5 = angS5+0.25;
  if(angS5>=360){
    angS5 = 0;
  }
  
  pushMatrix();
  rotateY(radians(angS1));
  translate(-width*0.15,0,0);
  rotateY(radians(angS1*2));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("BETA", 0,-90);
  fill(0,0,255);
  //sphere(30);
  shape(tierra);
  
  pushMatrix();
  rotateY(radians(angS1*6));
  translate(-width*0.03,0,0);
  rotateY(radians(angS1));
  fill(255,255,255);
  //textFont(createFont("Geogia",15));
  textAlign(CENTER,CENTER);
  text("LUNA", 0,-50);
  //sphere(15);
  shape(luna);
  
  angS1 = angS1+0.21;
  if(angS1>=360){
    angS1 = 0;
  }
  
  popMatrix();
  popMatrix();
  
  pushMatrix();
  rotateY(radians(angS2));
  translate(-width*0.25,0,0);
  rotateY(radians(angS2*4));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("GAMMA", 0,-90);
  //fill(234,214,184);
  //sphere(35);
  shape(venus);
  popMatrix();
  
  angS2 = angS2+0.17;
  if(angS2>=360){
    angS2 = 0;
  }
  
  
  pushMatrix();
  rotateY(radians(angS3));
  translate(-width*0.35,0,0);
  rotateY(radians(angS3*4));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("DELTA", 0,-90);
  shape(marte);
  fill(217,221,244);
  //sphere(40);
  popMatrix();
  
  angS3 = angS3+0.13;
  if(angS3>=360){
    angS3 = 0;
  }
  
  pushMatrix();
  rotateY(radians(angS4));
  translate(-width*0.45,0,0);
  rotateY(radians(angS4*2));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("EPSILON", 0,-90);
  noStroke();
  shape(jupiter);
  fill(225,238,238);
  //sphere(45);
  popMatrix();
  
  angS4 = angS4+0.09;
  if(angS4>=360){
    angS4 = 0;
  }
  
}
