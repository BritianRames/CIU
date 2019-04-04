import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
//Detectores
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

Capture cam;
CVImage img, auximg;
double uno,dos,tres,cuatro,media,suma;
int n = 16;
//Cascadas para detección
CascadeClassifier face,leye,reye;
//Nombres de modelos
String faceFile, leyeFile,reyeFile;
int xx, yy, ancho, alto;

void setup() {
  size(640, 480);
  //Cámara
  cam = new Capture(this, width , height);
  cam.start(); 
  xx = 0;
  yy = 0;
  ancho = height;
  alto = width;
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  auximg = new CVImage(cam.width, cam.height);
  
  //Detectores
  faceFile = "haarcascade_frontalface_default.xml";
  leyeFile = "haarcascade_mcs_lefteye.xml";
  reyeFile = "haarcascade_mcs_righteye.xml";
  face = new CascadeClassifier(dataPath(faceFile));
  leye = new CascadeClassifier(dataPath(leyeFile));
  reye = new CascadeClassifier(dataPath(reyeFile));
  textFont(createFont("Geogia",30));
}

void draw() {  
  if (cam.available()) {
    background(0);
    cam.read();
    
    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    
    //Imagen de grises
    Mat gris = img.getGrey();
    
    
    //TRATAMIENTO DE MATRIX PARA PIXELADO
    
    for(int i = xx; i<xx+alto;i=i+n){
      for(int j = yy-50; j<yy+ancho+50;j=j+n){
        //println("Y -> ", i, "   J -> ", j);
        
        for(int ii = i;ii<i+n;ii++){
          for(int jj = j;jj<j+n;jj++){
            //println("ANCHO -> ",ancho," ALTO -> ", alto, "(",ii,",",jj,")");
            if(ii < 640 && ii > 0 && jj > 0 && jj < 480){
              suma = suma + gris.get(jj,ii)[0];
            }
            
          }
        }
        
        media = suma/(n*n);
        
        for(int ii = i;ii<i+n;ii++){
          for(int jj = j;jj<j+n;jj++){
            if(ii < 640 && ii > 0 && jj > 0 && jj < 480){
              gris.put(jj,ii,media);
            }
          }
        }
        media = 0;
        suma = 0;
      }
    }
    
    //Copia de Mat a CVImage
    cpMat2CVImage(gris,auximg);
    
    //Detección y pintado de contenedores
    FaceDetect(gris);
    image(auximg,0,0);
    if(ancho == height && alto == width){
      textAlign(CENTER,CENTER);
      text("NO FACE DETECTED :(", width/2,height/2,0);
    }
    gris.release();
  }
}

void FaceDetect(Mat grey)
{
  Mat auxroi;
  
  //Detección de rostros
  MatOfRect faces = new MatOfRect();
  face.detectMultiScale(grey, faces, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(60, 60), new Size(200, 200));
  Rect [] facesArr = faces.toArray();
  
  //Dibuja contenedores
  for (Rect r : facesArr) { 
    if(facesArr.length == 1){
      xx = r.x;
      yy = r.y;
      ancho = r.width;
      alto = r.height;
    }
   }
  
  //Búsqueda de ojos
  MatOfRect leyes,reyes;
  for (Rect r : facesArr) {    
    //Izquierdo (en la imagen)
    leyes = new MatOfRect();
    Rect roi=new Rect(r.x,r.y,(int)(r.width*0.7),(int)(r.height*0.6));
    auxroi= new Mat(grey, roi);
    
    //Detecta
    leye.detectMultiScale(auxroi, leyes, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(30, 30), new Size(200, 200));
    leyes.release();
    auxroi.release(); 
     
     
    //Derecho (en la imagen)
    reyes = new MatOfRect();
    roi=new Rect(r.x+(int)(r.width*0.3),r.y,(int)(r.width*0.7),(int)(r.height*0.6));
    auxroi= new Mat(grey, roi);
    
    //Detecta
    reye.detectMultiScale(auxroi, reyes, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(30, 30), new Size(200, 200));
    reyes.release();
    auxroi.release(); 
  }
  
  faces.release();
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
