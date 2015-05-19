

import processing.serial.*;
 
Serial port;
 
PrintWriter output;  
int rquad=40; 
int xquad=200;  
int yquad=200;  

color white = color(255, 255, 255);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
int brightness = 0;

boolean overRect = false; //Estado del mouse si está encima de rect o no
 
//Colores del botón

 
boolean status=false; //Estado del color de rect
String texto="";//Texto del status inicial del LED
 
int xlogo=400;//Posición X de la imagen
int ylogo=50;//Posición Y de la imagen
 
int valor;//Valor de la velocidad
 

 
void setup()
{
  println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
  port = new Serial(this, Serial.list()[0], 9600); //Abre el puerto serie COM11
   
  output = createWriter("velocidad_datos.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa
   
  size(800, 400); //Creamos una ventana de 800 píxeles de anchura por 600 píxeles de altura 
}
 
void draw()
{
  background(255,255,255);//Fondo de color blanco
    
  fill(0,0,0);

  text(texto, 170, 270);
   
  //Ponemos la imagen de nuestro logo
  
for (int i = 0; i < 256; i++) {
    stroke(i);
    line(i, 0, i, 50);
  }
  
  
   int xpos = mouseX;
   int ypos = mouseY;
  
  
  if (xpos > 0 && xpos < 256)
  {
    if (ypos > 0 && ypos <= 50) {
      // brightness
      brightness = xpos;
      text("Aumento =",590,300);
      text(xpos, 720, 300);
      
      port.write(brightness);
      } 
  }
 
  //Recibir datos velocidad del Arduino 
  if(port.available() > 0) // si hay algún dato disponible en el puerto
   {
     valor=port.read();//Lee el dato y lo almacena en la variable "valor"
   }
   //Visualizamos la velocidad con un texto
   text("Velocidad =",590,200);
   text(valor, 720, 200);
   
    
   
  }
 
void mousePressed()  //Cuando el mouse está apretado
{
  if (overRect==true) //Si el mouse está dentro de rect
  {
    status=!status; //El estado del color cambia
    port.write("A"); //Envia una "A" al Arduino 
   
    
  }
}
 
void keyPressed() //Cuando se pulsa una tecla
{
 
  //Pulsar la tecla E para salir del programa
  if(key=='e' || key=='E')
  {
    output.flush(); // Escribe los datos restantes en el archivo
    output.close(); // Final del archivo
    exit();//Salimos del programa
  }
}
void setGradient(int x, int y, float w, float h, color c1, color c2) {

  noFill();

  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(i, y, i, y+h);
  }
}

