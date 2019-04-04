var radio;
var cuenta = 0;
let input, clearB, greeting, rS,gS,bS;
let rSlider, gSlider, bSlider, sizeSlider;
let pX = 0;
let pY = 0;
let comienza = true;

function setup()
{
  createCanvas(600,600);
  background(255);
  frameRate(10000);
  rSlider = createSlider(0, 255, 100);
  rSlider.position(250, 10);
  gSlider = createSlider(0, 255, 0);
  gSlider.position(250, 22);
  bSlider = createSlider(0, 255, 255);
  bSlider.position(250, 34);
  
  sizeSlider = createSlider(1, 50, 10);
  sizeSlider.position(90, 25);
  clearB = createButton('Limpiar');
  clearB.position(10 , 25);
  clearB.mousePressed(clear);
  
}

function draw()
{
  fill(100);
  rect(0,0,600,70);
  
  
  
  const r = rSlider.value();
  const g = gSlider.value();
  const b = bSlider.value();
  //background(r, g, b);
  rS = "ROJO";
  gS = "VERDE";
  bS = "AZUL";
  fill(255);
  text(rS, rSlider.x + rSlider.width +10, rSlider.y+10);
  text(gS, gSlider.x + gSlider.width+10, gSlider.y+12);
  text(bS, bSlider.x + bSlider.width+10, bSlider.y+14);
  text(r, rSlider.x + rSlider.width +60, rSlider.y+10);
  text(g, gSlider.x + gSlider.width+60, gSlider.y+12);
  text(b, bSlider.x + bSlider.width+60, bSlider.y+14);
  
  radio = sizeSlider.value();
  
  text('Tamaño Pincel :'+radio, 110, 20);
  //noStroke();
  fill(r,g,b);
  rect(500,0,600,70);
  let comprueba = true;
  if(mouseIsPressed && mouseY > 80){
    comprueba = false;
    //ellipse(mouseX, mouseY, radio, radio);
    stroke(r,g,b);
    strokeWeight(radio*2);
    if(!comienza){
      line(mouseX,mouseY,pX,pY);
    } else {
      comienza = false;
    }
    pX = mouseX;
    pY = mouseY;
    noStroke();
  }
  if(comprueba == true && comienza==false){
     comienza = true;
  }
  
  cuenta++;
}

function clear(){
  background(255);
  fill(0);
  stroke(0);
  rect(0,0,600,30);
  comienza = true;
  wait();
}