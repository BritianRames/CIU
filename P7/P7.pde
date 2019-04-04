
import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

SoundFile file;
Minim minim;
//Entrada
AudioInput IN;
FFT fft;

PImage img1, img2;
PShape esfera1 , esfera2;
float angulo;


int cols, rows;
int escala = 10;
int w = 1000;
int h = 400;
int iter = 0;
boolean interruptor = true;
float[][] ground;

float num;

int bands = 64;
float[] spectrum = new float[bands];

void setup() {
  size(600, 600, P3D);
  
  angulo = 360;
  img1 = loadImage("1.png" );
  img2 = loadImage("2.png" );
  noStroke();
  esfera1 = createShape(SPHERE, 100);
  esfera1.setTexture(img1);
  esfera2 = createShape(SPHERE, 100);
  esfera2.setTexture(img2);
  cols = w / escala;
  rows = h/ escala;
  ground = new float[cols][rows];
  
  file = new SoundFile(this, "Tom Walker - Rapture (Audio).mp3");
  //file = new SoundFile(this, "malam.mp3");
  //file.loop();
  
  minim = new Minim(this);
  
  // Línea estéreo de entrada, 44100 Hz 16 bits
  IN = minim.getLineIn(Minim.STEREO, 2048);
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      ground[x][y] = 0;
    }
  }
  
  fft = new FFT(this, bands);
  fft.input(file);
   
}


void draw() {
  background(0);
  if(file.isPlaying()){
    directionalLight(0,0,255,-1,0,-1);
    directionalLight(255,0,0,1,0,-1);
    directionalLight(0,255,0,0,1,-1);
    directionalLight(100,100,25,0,-1,-1);
    
  }
  if(mousePressed){
    if(file.isPlaying() == false){
      file.play();
    }else{
      file.pause();
    }
    delay(200);
  }
  
  for (int y = rows-1; y > 0 ; y--) {
    for (int x = 0; x < cols; x++) {
     ground[x][y] = ground[x][y-1];
    }
  } 
  
  if(file.isPlaying() == false){
    for (int x = 0; x < cols; x++) {
      ground[x][0] = IN.left.get(iter)*height;
      
      iter = iter +2;
    }
    println(ground[0][0]);
    iter = 0;
    
  } else {
    fft.analyze(spectrum);
    for (int x = 0; x < (cols/2)+1; x++) {
    
      num = map(spectrum[x], 0, 1, 0, 500);
      ground[x][0] = num;
      ground[cols-x-1][0] = num;
      
    }
  }
  
  pushMatrix();
  translate(width/2, height/2,0);
  rotateY(radians(angulo));
  noStroke();
  if(file.isPlaying() == false){
    shape(esfera1);
  }else{
    shape(esfera2);
  }
  
  angulo = angulo-0.7;
  if(angulo>=360){
    angulo = 0;
  }
  
  popMatrix();
  
  if(file.isPlaying() == false){
    stroke(255);
    
    noFill();
  } else {
    fill(255);
  }
  
  pushMatrix();
  translate(width/2, height/2,-500);
  rotateX(PI/2);
  pushMatrix();
  translate(-w/2, -h/2,-300);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*escala, y*escala, ground[x][y]);
      vertex(x*escala, (y+1)*escala, ground[x][y+1]);
      //rect(x*escala, y*escala, escala, escala);
    }
    endShape();
  }
  popMatrix();
  pushMatrix();
  translate(-w/2, -h/2,300);
  //rotateY(radians(180));
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*escala, y*escala, -ground[x][y]);
      vertex(x*escala, (y+1)*escala, -ground[x][y+1]);
      //rect(x*escala, y*escala, escala, escala);
    }
    endShape();
  }
  popMatrix();
  popMatrix();
  
}
