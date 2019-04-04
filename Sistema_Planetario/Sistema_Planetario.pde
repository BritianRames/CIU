float dx,dy,dz,z,vx,vy,vz,vx2,vz2,vx0,vy0,vz0;
float ang, ang2, angEstrella, angMercurio, angTierra, angVenus, angMarte, angJupiter;
PImage img,imgSol, imgMercurio, imgLatierra,imgVenus, imgLuna, imgMarte, imgJupiter;
PShape galaxy, sun, mercurio, venus, tierra, marte, jupiter, luna, nave, target;
boolean camaraMode = false;

void setup(){
  frameRate(50);
  size(1400,800,P3D);
  background(100);
  vx0 = width/2;
  vy0 = height/2;
  vz0 = 0;
  dx = width/2;
  dy = height/2;
  dz = 500;
  z = 700;
  ang = 0;
  ang2 = 0;
  vx = width/2;
  vy = height/2;
  vz = 0;
  
  angEstrella = 0;
  angMercurio = 0;
  angTierra = 0;
  angVenus = 0;
  angMarte = 0;
  angJupiter = 0;
  
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
  nave = loadShape("OVNI2.obj");
  //nave.setTexture(imgMarte);
  //nave.scale(0.1);
  target = createShape(SPHERE, 15);
  target.setTexture(imgMarte);
  
  textFont(createFont("Geogia",30));
  
}

void draw(){
  
  if(keyPressed){
    if(key == 'd'){
      ang = ang - 2;
      vx = dx + (-500*sin(radians(ang)));
      //vz = dz + (-500*cos(radians(ang)));
      vy = dy + (-500*cos(radians(ang))*sin(radians(ang2)));
      vz = dz + (-500*cos(radians(ang))*cos(radians(ang2)));
    }
    if(key == 'a'){
      ang = ang +2;
      vx = dx + (-500*sin(radians(ang)));
      vy = dy + (-500*cos(radians(ang))*sin(radians(ang2)));
      //vz = dz + (-500*cos(radians(ang)));
      vz = dz + (-500*cos(radians(ang))*cos(radians(ang2)));
    }
    //if(ang >= 360) ang = 0;
    if(key == 's'){
      dx = dx + 5*sin(radians(ang));
      dy = dy + 5*cos(radians(ang))*sin(radians(ang2));
      //dz = dz + 5*cos(radians(ang));
      dz = dz + 5*cos(radians(ang))*cos(radians(ang2));
      //
      vx = vx + 5*sin(radians(ang));
      vy = vy + 5*cos(radians(ang))*sin(radians(ang2));
      //vz = vz + 5*cos(radians(ang));
      vz = vz + 5*cos(radians(ang))*cos(radians(ang2));
      
    }
    if(key == 'w'){
      dx = dx - 5*sin(radians(ang));
      dy = dy - (5*cos(radians(ang))*sin(radians(ang2)));
      //dz = dz - 5*cos(radians(ang));
      dz = dz - (5*cos(radians(ang))*cos(radians(ang2)));
      //
      vx = vx - 5*sin(radians(ang));
      vy = vy - (5*cos(radians(ang))*sin(radians(ang2)));
      //vz = vz - 5*cos(radians(ang));
      vz = vz - (5*cos(radians(ang))*cos(radians(ang2)));
      
    }
    if(key == 'k'){
      ang2 = ang2 + 2;
      vx = dx + (-500*sin(radians(ang)));
      vy = dy +(-500*cos(radians(ang))*sin(radians(ang2)));
      vz = dz +(-500*cos(radians(ang))*cos(radians(ang2)));
      //dy=dy +5;
      //vy=vy +5;
    }
    
    if(key == 'm'){
      ang2 = ang2 - 2;
      vx = dx + (-500*sin(radians(ang)));
      vy = dy +(-500*cos(radians(ang))*sin(radians(ang2)));
      vz = dz +(-500*cos(radians(ang))*cos(radians(ang2)));
      //dy=dy -5;
      //vy=vy -5;
    }
    
    if(key == 'p'){
      camaraMode = true;
    }
    
    if(key == 'o'){
      camaraMode = false;
    }
    
  }
  
  
  background(img);
  //lightSpecular(255,255,255);
  //pointLight(255,255,255,dx,dy,dz);
  pushMatrix();
  translate(width/2,height/2,0);
  
  //pointLight(255 , 255 , 255 , 150, 140, 0);
  //pointLight(255 , 255 , 255 , 150, -140, 0);
  //pointLight(255 , 255 , 255 , -150, 140, 0);
  //pointLight(255 , 255 , 255 , -150, -140, 0);
  //pointLight(255 , 255 , 255 , 0, 140, -150);
  //pointLight(255 , 255 , 255 , 0, 140, 150);
  //pointLight(255 , 255 , 255 , 0, -140, -150);
  //pointLight(255 , 255 , 255 , 0, -140, 150);
  
  ////////////////////////////////////
  
  pushMatrix();
  rotateX(radians(90));
  noFill();
  strokeWeight(1);
  stroke(255,255,255);
  ellipse(0,0,(width*2)*0.10,(width*2)*0.10);
  ellipse(0,0,(width*2)*0.15,(width*2)*0.15);
  ellipse(0,0,(width*2)*0.25,(width*2)*0.25);
  ellipse(0,0,(width*2)*0.35,(width*2)*0.35);
  ellipse(0,0,(width*2)*0.45,(width*2)*0.45);
  
  popMatrix();
  
  pushMatrix();
  
  fill(255,255,255);
  //textFont(createFont("Geogia",30));
  noStroke();
  textAlign(CENTER,CENTER);
  text("ESTRELLA", 0,-130);
  rotateY(radians(angEstrella));
  fill(243,159,24);
  //sphere(100);
  shape(sun);
  popMatrix();

  angEstrella = angEstrella+0.25;
  if(angEstrella>=360){
    angEstrella = 0;
  }
  
  
  pushMatrix();
  rotateY(radians(angMercurio));
  translate(-width*0.10,0,0);
  rotateY(radians(angMercurio));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("ALPHA", 0,-90);
  fill(203,129,11);
  //sphere(20);
  shape(mercurio);
  popMatrix();
  
  angMercurio = angMercurio+0.35;
  if(angMercurio>=360){
    angMercurio = 0;
  }
  
  
  pushMatrix();
  rotateY(radians(angTierra));
  translate(-width*0.15,0,0);
  rotateY(radians(angTierra*2));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("BETA", 0,-90);
  fill(0,0,255);
  //sphere(30);
  shape(tierra);
  
  pushMatrix();
  rotateY(radians(angTierra*6));
  translate(-width*0.03,0,0);
  rotateY(radians(angTierra));
  fill(255,255,255);
  //textFont(createFont("Geogia",15));
  textAlign(CENTER,CENTER);
  text("LUNA", 0,-50);
  //sphere(15);
  shape(luna);
  
  angTierra = angTierra+0.21;
  if(angTierra>=360){
    angTierra = 0;
  }
  
  popMatrix();
  popMatrix();
  
  
  
  pushMatrix();
  rotateY(radians(angVenus));
  translate(-width*0.25,0,0);
  rotateY(radians(angVenus*4));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("GAMMA", 0,-90);
  //fill(234,214,184);
  //sphere(35);
  shape(venus);
  popMatrix();
  
  angVenus = angVenus+0.17;
  if(angVenus>=360){
    angVenus = 0;
  }
  
  
  pushMatrix();
  rotateY(radians(angMarte));
  translate(-width*0.35,0,0);
  rotateY(radians(angMarte*4));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("DELTA", 0,-90);
  shape(marte);
  fill(217,221,244);
  //sphere(40);
  popMatrix();
  
  angMarte = angMarte+0.13;
  if(angMarte>=360){
    angMarte = 0;
  }
  
  
  pushMatrix();
  rotateY(radians(angJupiter));
  translate(-width*0.45,0,0);
  rotateY(radians(angJupiter*2));
  fill(255,255,255);
  //textFont(createFont("Geogia",20));
  textAlign(CENTER,CENTER);
  text("EPSILON", 0,-90);
  noStroke();
  shape(jupiter);
  fill(225,238,238);
  //sphere(45);
  popMatrix();
  
  angJupiter = angJupiter+0.09;
  if(angJupiter>=360){
    angJupiter = 0;
  }
  
  popMatrix();
  
  
  
  pushMatrix();
  translate(dx,dy,dz);
  
  rotateY(radians(-90));
  rotateX(radians(90));
  
  rotateZ(radians(-ang));
  rotateY(radians(ang2));
  scale(0.04);
  nave.setFill(color(random(255),random(255),random(255)));
  shape(nave);
  
  popMatrix();
  
  if(!camaraMode){
    pushMatrix();
    translate(width/2,height/2,0);
    rotateX(radians(12));
    fill(255,255,255);
    textAlign(CENTER,CENTER);
    String s = "(x = "+str(int(dx))+" ) (y = "+ str(int(dy)) +" ) (z = "+str(int(dz))+" )";
    text(s,width/2,height/2,0);
    text("(W) FORWARD (S) BACKWARD",width/2,height/2+30,0);
    text("(A) ROTATE LEFT (D) ROTATE RIGHT",width/2,height/2+60,0);
    text("(K) LOOK UP (M) LOOK DOWN",width/2,height/2+90,0);
    text("(P) ACTIVATE SPACECRAFT VIEW (O) DESACTIVATE SPACECRAFT VIEW",0,height/2-700,0);
    popMatrix();
  }
  
  ////////////////////////////////////
  
  if(camaraMode){
    camera(dx,dy,dz,vx,vy,vz,0,1,0);
  } else if(!camaraMode){
    camera(width/2,height/2-300,1000,width/2,height/2,0,0,1,0);
  }
  
}
