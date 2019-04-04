import processing.sound.*;

boolean wait = false;
int marcador1 = 0;
int marcador2 = 0;

boolean imposible = false;

int turno;
boolean gol = false;
int contador = 0;

int rad = 10;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

boolean comienza = true;
int xdirection;  // Left or Right
int ydirection;  // Top to Bottom

int player1_y = 250;
int player2_y = 250;

int estado = 0;

SoundFile sonido_rebote, sonido_fin;

void setup()
{
  sonido_rebote = new SoundFile ( this , "./prueba.wav" ) ;
  sonido_fin = new SoundFile ( this , "./endplay.wav" ) ;
  
  size(1000,550);
  background(128,128,128);
  frameRate(100);
  stroke(0);
  
  fill(255,255,255);
  textFont(createFont("Geogia",24));
  textAlign(CENTER,CENTER);
  text("VS", 500,20);
  text("PLAYER 1", 250,20);
  text("PLAYER 2", 750,20);
  
  //player 1
  noStroke();
  fill(255,255,0);
  rect(900,player1_y,10,60);
  //player 2
  noStroke();
  fill(255,0,255);
  rect(100,player2_y,10,60);
  
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  
  
  
}

void draw()
{
  if(estado == 0){
    setStage();
    printPlayers();
    printBall();
    //descomentar para jugar con bot
    if(imposible == true){
      botPlayer();
    }
  }
  
  if(estado == 1){
    setStage();
    printPlayers();
    textFont(createFont("Arial",49));
    fill(255,255,255);
    text("GOOOOOOOOOOOOOOOOL",width/2,height/2 -100);
    if(mousePressed == true){
      estado = 0;
      gol = false;
    }
    text("CLICK (MOUSE) TO CONTINUE",width/2,height/2 +100);
    textFont(createFont("Arial",30));
    text("PRESS (R) TO RESET SCORE",width/2,height/2 +250);
  }
  
  if(estado == 2){
    marcador1 = 0;
    marcador2 = 0;
    estado = 0;
  }
  
  if(estado == 3){
    setStage();
    if(marcador1 < marcador2){
      text("PLAYER 2 WINSSS!!!!!!!!!!!!!",width/2,height/2);
    }
    if(marcador1 > marcador2){
      text("PLAYER 1 WINSSS!!!!!!!!!!!!!",width/2,height/2);
    }
    if(marcador1 == marcador2){
      text("TIE!!!!!",width/2,height/2);
    }
    text("CLICK (MOUSE) FOR NEW MATCH",width/2,height/2 +150);
    if(mousePressed == true){
      estado = 2;
      gol = false;
    }
  }
}

void suena_rebote(){
  sonido_rebote.play();
}

void suena_fin(){
  sonido_fin.play();
}

void botPlayer(){
 if(ypos < 130){
    player2_y = 130;
  } else if(ypos > 520){
    player2_y = 520;
  }  else if (ypos >= 130 && ypos <= 520){
    player2_y = int(ypos);
  }
}

void printPlayers(){
  //player 1
  noStroke();
  fill(255,0,0);
  rect(100,player1_y-30,10,60);
  //player 2
  noStroke();
  fill(255,255,0);
  rect(900,player2_y-30,10,60);
}

void setStage(){
  background(128,128,128);
  stroke(0);
  fill(0,0,0);
  rect(0,0,1000,100);
  fill(255,255,255);
  textFont(createFont("Geogia",24));
  textAlign(CENTER,CENTER);
  text("VS", 500,20);
  text("PLAYER 1", 250,20);
  text("PLAYER 2", 750,20);
  
  text(marcador1, 250,65);
  text(marcador2, 750,65);
  text(marcador2+marcador1+"/6", 500,65);
  
}


void actualizar(int jugadorPerdedor){
  thread("suena_fin");
  gol = true;
  estado = 1;
  
  
  xpos = width/2;
  ypos = height/2;
  
  if (jugadorPerdedor == 1){
    marcador2 += 1;
  } else if(jugadorPerdedor == 2) {
    marcador1 += 1;
  }
  
  //Actualizamos velocidades aleatoriamente
  xspeed = random(1.2,4);
  yspeed = random(2,4); 
  
  if(marcador1+marcador2 == 6){
    estado = 3;
  }
  
  comienza = true;
}


void printBall(){
  
  //en caso de comenzar, actualizamos la trayectoria de la bola aleatoriamente.
  if(comienza){
    xdirection = 0;
    ydirection = 0;
    while(xdirection == 0){
      xdirection = int(random(-2,2));
    }
    while(ydirection == 0){
      ydirection = int(random(-2,2));
    }
    comienza = false;
    turno = xdirection;
  }
  
  // actualizamos la posición de la bola
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Comprobamos si ha llegado a los limites del espacio.
  // En ese caso multiplicamos por -1 la coordenada afectada.
  if (xpos >= 900-rad && turno == 1) {
    if(ypos >= player2_y-30 && ypos <= player2_y+30 && xpos <= 902){
      xdirection *= -1;
      thread("suena_rebote");
      turno *= -1;
    }
  }
  if (xpos <= 110+rad && turno == -1){
    if(ypos >= player1_y-30 && ypos <= player1_y+30 && xpos >=108){
      xdirection *= -1;
      thread("suena_rebote");
      turno *= -1;
    }
  }
  
  if (xpos < 15){
    actualizar(1);
  }
  if (xpos > 985){
    actualizar(2);
  }
  
  if (ypos > height-rad || ypos < rad+100) {
    ydirection *= -1;
    thread("suena_rebote");
  }

  // Draw the shape
  fill(255,255,255);
  ellipse(xpos, ypos, rad, rad);
}

void mouseMoved()
{
  if(mouseY <130){
    player1_y = 130;
  } else if(mouseY > 520){
    player1_y = 520;
  } else if (mouseY >= 130 && mouseY <= 520){
    player1_y = mouseY;
  }
}



void keyPressed() {
  if(key == 'R'){
    estado = 2;
  }
  if(key == 'P'){
    if(imposible == true){
      imposible = false;
    } else {
      imposible = true;
    }
  }
  if(key == 'a'){
    if(player2_y <= 130){
      player2_y = 130;
    } else {
      player2_y = player2_y - 15;
    }
  } if(key == 'z'){
    if(player2_y >= 520){
      player2_y = 520;
    } else {
      player2_y = player2_y + 15;
    }
  }
}
