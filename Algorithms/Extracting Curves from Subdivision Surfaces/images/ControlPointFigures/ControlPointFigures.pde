int resolution = 128;
PGraphics g;

void setup()
{
  // Call this first to set the width and height variables to the correct sizes.
  //fullScreen();
  //size(512, 512);
  size(1000, 1000);
  g = createGraphics(width, height);
}


void draw()
{
    g.beginDraw();
  
    background(255);
  
    g.stroke(45, 45, 45);
        
    g.strokeWeight(4);

    int n = 4;
    float[] control_x = new float[n*n];
    float[] control_y = new float[n*n];
  
    // The size of squares on the grid.
    int size = width/(n + 1);
  
  
    // NOTE, bottom left is index 0,0, x increases to the right, y increases towards the top of the screen.
  
    for(int i = 0; i < n*n; i++)
    {
      float angle = 2*PI*i/n/n;
      float r = size /10.0;
      control_x[i] = (i % 4) * size + size + r*cos(angle);
      control_y[i] = height - size - (i / 4) * size + r*sin(angle);
    }
    
    for(int r = 0; r < n; r++)
    for(int c = 0; c < n; c++)
    {
      g.fill(255);
      int index = r*4 + c;
      
      float gap = size/5;
      
      // Up line.
      if(r < n - 1)
      {        
        //g.line(control_x[index], control_y[index], control_x[index + 4], control_y[index + 4]);
        //drawArrow(control_x[index], control_y[index] - gap, control_x[index + 4], control_y[index + 4] + gap, 10, g);
      }

      if(c < n - 1)
      {
        //g.line(control_x[index], control_y[index], control_x[index + 1], control_y[index + 1]);
        drawArrow(control_x[index] + gap, control_y[index], control_x[index + 1] - gap, control_y[index + 1], 10, g);
      }

      float x = control_x[index];
      float y = control_y[index];
      
      g.ellipse(x, y, size/10.0, size/10.0);
      
      g.textAlign(CENTER, CENTER);
      g.fill(0, 0, 0);
      g.textSize(size/4.0);
      
      if(c < n -1) // Draw u tangent labels.
      g.text("U" + c + r, x + size/2, y + size/4);
      
      
      //if(r > 0) // Draw v tangent labels.
      //g.text("V" + c + (r - 1), x + size/3, y + size/2);
    }

  g.endDraw();
  image(g, 0, 0);

  g.save("output.png");
  noLoop();
}



void keyPressed()
{
  
  // If the user presses space, then this program will save a nice transparent image of the fractal in the local file output.png.
  if (key == ' ')
  {
    save("output.png");
    
  }
}

// Draws an arrow from 1 pointing to 2.
void drawArrow(float x1, float y1, float x2, float y2, float head_length, PGraphics g)
{
  g.line(x1, y1, x2, y2);
  
  float dx = x2 - x1;
  float dy = y2 - y1;
  float mag = dist(x1, y1, x2, y2);
  
  float par_x = dx/mag;
  float par_y = dy/mag;
  
  float perp_x = -par_y;
  float perp_y =  par_x;

  // Draw one of the arrow heads.
  g.line(x2, y2, x2 - par_x*head_length + perp_x*head_length,
    y2 - par_y*head_length + perp_y*head_length);
    
  // Draw the other.
  g.line(x2, y2, x2 - par_x*head_length - perp_x*head_length,
                 y2 - par_y*head_length - perp_y*head_length);
}