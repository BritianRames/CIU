import processing.sound.*;
SoundFile sonido_rebote;

int rad = 100;        // Width of the shape
float xpos, ypos, zpos;    // Starting position of shape 

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape
float zspeed = 2.1;

boolean comienza = true;
int xdirection;  // Left or Right
int ydirection;  // Top to Bottom
int zdirection;

int player1_y = 250;
int player2_y = 250;

int estado = 0;
PShape ball, boxX, boxY,boxZ;
PImage imgBall, textureX,textureY;

int cameraX = 400;
int cameraY = 400;

boolean lightMode = false;
boolean emisive = false;

float R,G,B;
String s;


void setup(){
  size(800,800,P3D);
  sonido_rebote = new SoundFile ( this , "./prueba.wav" );
  sphereDetail(100);
  xpos = width/2;
  ypos = height/2;
  zpos = 0;
  imageMode(CENTER);
  imgBall=loadImage("ilusion1.gif" ) ;
  R = 100;
  G = 100;
  B = 200;
  noStroke();
  
  ball = createShape(SPHERE, 80);
  ball.setTexture(imgBall);
  
  boxX = createShape();
  boxX.beginShape(QUADS);
  boxX.vertex(0,0,400);
  boxX.vertex(0,0,-400);
  boxX.vertex(0,800,-400);
  boxX.vertex(0,800,400);
  
  boxX.vertex(800,0,400);
  boxX.vertex(800,0,-400);
  boxX.vertex(800,800,-400);
  boxX.vertex(800,800,400);
  boxX.endShape();
  
  boxY = createShape();
  boxY.beginShape(QUADS);
  
  boxY.vertex(0,0,400);
  boxY.vertex(0,0,-400);
  boxY.vertex(800,0,-400);
  boxY.vertex(800,0,400);
  
  boxY.vertex(0,800,400);
  boxY.vertex(0,800,-400);
  boxY.vertex(800,800,-400);
  boxY.vertex(800,800,400);
  boxY.endShape();
  
  boxZ = createShape();
  boxZ.beginShape(QUADS);
  boxZ.vertex(0,0,-400);
  boxZ.vertex(0,800,-400);
  boxZ.vertex(800,800,-400);
  boxZ.vertex(800,0,-400);
  boxZ.endShape();
  
  textFont(createFont("Geogia",30));
}

void draw(){
  background(125);
  
  if(keyPressed){
    if(key == 'a'){
      if(cameraX > -800)cameraX = cameraX - 10;
    }
    if(key == 'd'){
      if(cameraX < 1200)cameraX = cameraX + 10;
    }
    if(key == 'w'){
      if(cameraY > -800)cameraY = cameraY - 10;
    }
    if(key == 's'){
      if(cameraY < 1200)cameraY = cameraY + 10;
    }
    if(key == 'o') lightMode = true;
    if(key == 'p') lightMode = false;
    if(key == 'n') emisive = true;
    if(key == 'm') emisive = false;
    if(key == 'r') R = R + 0.2;
    if(key == 'g') G = G + 0.2;
    if(key == 'b') B = B + 0.2;
    if(R >= 256)R = 0;
    if(G >= 256)G = 0;
    if(B >= 256)B = 0;
  }
  camera(cameraX,cameraY,2000,400,400,0,0,1,0);
  
  if(lightMode){
    textAlign(CENTER,CENTER);
    s = "Press 'P' to enter the cavern. " + "\nPress 'A', 'D', 'W' or 'S' to move camera. " + "\nPress 'R', 'G' or 'B' to modify lights." +"\nRed = "+ int(R) + "\nGreen = " + int(G) + "\nBlue = " + int(B);
    text(s, 0,-300,400);
    pointLight(R,G,B,cameraX,cameraY,1000);
    if(emisive)smooth(100);
  }
  if(!lightMode){
    textAlign(CENTER,CENTER);
    text("Press 'O' to exit the cavern.", 0,-300,400);
  }
  shape(boxX);
  shape(boxY);
  shape(boxZ);
  printBall();
}

void printBall(){
  
  //en caso de comenzar, actualizamos la trayectoria de la bola aleatoriamente.
  if(comienza){
    xdirection = 0;
    ydirection = 0;
    zdirection = 0;
    while(xdirection == 0){
      xdirection = int(random(-2,2));
    }
    while(ydirection == 0){
      ydirection = int(random(-2,2));
    }
    while(zdirection == 0){
      zdirection = int(random(-2,2));
    }
    comienza = false;
  }
  
  // actualizamos la posición de la bola
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  zpos = zpos + ( zspeed * zdirection );
  
  
  if (ypos > 720 || ypos < 80) {
    ydirection *= -1;
    thread("suena_rebote");
  }
  if (xpos > 720 || xpos < 80) {
    xdirection *= -1;
    thread("suena_rebote");
  }
  if (zpos > 320 || zpos < -320) {
    zdirection *= -1;
    thread("suena_rebote");
  }

  // Draw the shape
  fill(255,255,255);
  pushMatrix();
  translate(xpos,ypos,zpos);
  shape(ball);
  popMatrix();
}

void suena_rebote(){
  sonido_rebote.play();
}
