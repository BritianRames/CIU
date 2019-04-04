import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.imgproc.Imgproc;
double uno,dos,tres,cuatro,media,suma;
int n = 16;//2,4,8,16,32
String s;
Capture cam;
CVImage img,auximg;

void setup() {
  size(1280, 480);
  //Cámara
  cam = new Capture(this, width/2 , height);
  cam.start(); 
  
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  //Crea imágenes
  img = new CVImage(cam.width, cam.height);
  auximg=new CVImage(cam.width, cam.height);
  
  textFont(createFont("Geogia",30));
}

void draw() { 
  if(keyPressed){
    if(key == 'a'){
      if(n<=16)n = n *2;
      setup();
    }
    if(key == 'd'){
      if(n>=4)n = n / 2;
      setup();
    }
  }
  
  println(n);
  if (cam.available()) {
    background(0);
    cam.read();
    
    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    
    //Imagen de grises
    Mat gris = img.getGrey();
    
    gris.put(100,100,0);
    
    for(int i = 0; i<480;i=i+n){
      for(int j = 0; j<640;j=j+n){
        //println("Y -> ", i, "   J -> ", j);
        
        for(int ii = i;ii<i+n;ii++){
          for(int jj = j;jj<j+n;jj++){
            suma = suma + gris.get(ii,jj)[0];
          }
        }
        
        media = suma/(n*n);
        
        for(int ii = i;ii<i+n;ii++){
          for(int jj = j;jj<j+n;jj++){
            gris.put(ii,jj,media);
          }
        }
        media = 0;
        suma = 0;
        /*
        uno = gris.get(i,j)[0];
        dos = gris.get(i+1,j)[0];
        tres = gris.get(i,j+1)[0];
        cuatro = gris.get(i+1,j+1)[0];
        media = (uno+dos+tres+cuatro)/4;
        gris.put(i,j,media);
        gris.put(i+1,j,media);
        gris.put(i,j+1,media);
        gris.put(i+1,j+1,media);
        */
      }
    }
    
    //Aplica Canny
    //Imgproc.Canny(gris,gris,20,60,3);
    
    //Copia de Mat a CVImage
    cpMat2CVImage(gris,auximg);
    
    //Visualiza ambas imágenes
    image(img,0,0);
    image(auximg,width/2,0);
    
    textAlign(CENTER,CENTER);
    fill(200,100,0);
    s = "PIXEL SIZE = " + n;
    text(s,(width/4)*3,60);
    
    gris.release();
  }
}

//Copia unsigned byte Mat a color CVImage
void  cpMat2CVImage(Mat in_mat,CVImage out_img)
{    
  byte[] data8 = new byte[cam.width*cam.height];
  
  out_img.loadPixels();
  in_mat.get(0, 0, data8);
  
  // Cada columna
  for (int x = 0; x < cam.width; x++) {
    // Cada fila
    for (int y = 0; y < cam.height; y++) {
      // Posición en el vector 1D
      int loc = x + y * cam.width;
      //Conversión del valor a unsigned basado en 
      //https://stackoverflow.com/questions/4266756/can-we-make-unsigned-byte-in-java
      int val = data8[loc] & 0xFF;
      //Copia a CVImage
      out_img.pixels[loc] = color(val);
    }
  }
  out_img.updatePixels();
}
