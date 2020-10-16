//BUG FIX: EVEN WHEN THERE IS NO SPACE TO MOVE UP, IF YOU TRIGGER THE MOVE UP, IT WILL SPAWN SOMETHING
//BUG FIX: FRAME PERFECT, CREATE AN ABOUT TO BE STILL, TO DO RANDOM SPAWN 1 frame before stoppage of movement
//futureval function for merging

Tile tiles[][] = new Tile[4][4];
Tile back[][] = new Tile[4][4];
String keypressednow = "None";
float pixelsperframe = 194/6;
boolean justMoved = false;

void setup()
{
  frameRate(60);
  size(1100,800);
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      tiles[i][j] = new Tile(i,j);
      tiles[i][j].setval(0);
      tiles[i][j].setFval(0);
      tiles[i][j].update();
      back[i][j] = new Tile(i,j);
      back[i][j].setval(0);
      back[i][j].setFval(0);
      back[i][j].update();
      back[i][j].setback();
    }
  }
  //tiles[1][1].setval(2);
  //tiles[1][2].setval(8);
  //tiles[3][1].setval(4);
  randomSpawn();
}
void draw() 
{
  
  background(182, 173, 160);
  //------------------------------------------------------------------
  //sidebar
  fill(255);
  rect(800,0,300,800,5);
  
  fill(182, 173, 160);
  rect(850,100,200,200,5);
  
  fill(224, 212, 200);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Key pressed", 950, 150); 
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  if(!keyPressed)
  {
  text("none", 950, 200); 
  }
  else
  {
  text(keypressednow, 950, 200); 
  }
  //----------------------------------------------------------------------
  //input and move
  if(keyPressed && allAreStill())
  {
    if(keypressednow.equals("up"))
    {
      moveAllUp();
      justMoved = true;
    }
    if(keypressednow.equals("down"))
    {
      moveAllDown();
      justMoved = true;
    }
    if(keypressednow.equals("left"))
    {
      moveAllLeft();
      justMoved = true;
    }
    if(keypressednow.equals("right")) 
    {
      moveAllRight();
      justMoved = true;
    }
  }
  //----------------------------------------------------------------------
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      back[i][j].display();
    }
  }
  if(justMoved && allAreStill())
  {
    justMoved = false;
    randomSpawn();
  }
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      tiles[i][j].update();
      tiles[i][j].display();
    }
  }
}

void moveAllRight()
{
  for(int j = 0;j<4;j++)
  {
    for(int i = 3;i>=0;i--)
    {
      if(tiles[i][j].getval()!=0)
      {
        int move = horizontal_check(tiles[i][j],1);
        int merge = second_horizontal_check(tiles[i][j],1);
        tiles[i+move+merge][j] = tiles[i][j].clone();
        if(merge!=0) tiles[i+move+merge][j].setFval(tiles[i][j].getval()*2);
        tiles[i+move+merge][j].setxy(i+move+merge,j);
        tiles[i+move+merge][j].moveRight(move+merge);
        if((move+merge)!=0)
        {
          tiles[i][j].setval(0);
          tiles[i][j].setFval(0);
        }
      }
    }
  }
}

void moveAllLeft()
{
  for(int j = 0;j<4;j++)
  {
    for(int i = 0;i<4;i++)
    {
      if(tiles[i][j].getval()!=0)
      {
        int move = horizontal_check(tiles[i][j],-1);
        tiles[i-move][j] = tiles[i][j].clone();
        tiles[i-move][j].setxy(i-move,j);
        tiles[i-move][j].moveLeft(move);
        if(move!=0)
        {
          tiles[i][j].setval(0);
          tiles[i][j].setFval(0);
        }
      }
    }
  }
}

void moveAllUp()
{
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getval()!=0)
      {
        int move = vertical_check(tiles[i][j],-1);
        tiles[i][j-move] = tiles[i][j].clone();
        tiles[i][j-move].setxy(i,j-move);
        tiles[i][j-move].moveUp(move);
        if(move!=0)
        {
          tiles[i][j].setval(0);
          tiles[i][j].setFval(0);
        }
      }
    }
  }
}

void moveAllDown()
{
  for(int i = 0;i<4;i++)
  {
    for(int j = 3;j>=0;j--)
    {
      if(tiles[i][j].getval()!=0)
      {
        int move = vertical_check(tiles[i][j],1);
        tiles[i][j+move] = tiles[i][j].clone();
        tiles[i][j+move].setxy(i,j+move);
        tiles[i][j+move].moveDown(move);
        if(move!=0)
        {
          tiles[i][j].setval(0);
          tiles[i][j].setFval(0);
        }
      }
    }
  }
}

int second_horizontal_check(Tile tile, int direction)
{
  int ans = 0;
  int x = tile.getx();
  int y = tile.gety();
  for(int i = x+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[i][y].getFval()==tile.getval())ans++;
    if(tiles[i][y].getFval()!=0 && tiles[i][y].getFval()!=tile.getval()) break;
  }
  return ans;
}

int horizontal_check(Tile tile, int direction)
{
  int ans = 0;
  int x = tile.getx();
  int y = tile.gety();
  for(int i = x+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[i][y].getval()==0) ans++;
  }
  return ans;
}

int vertical_check(Tile tile, int direction)
{
  int ans = 0;
  int x = tile.getx();
  int y = tile.gety();
  for(int i = y+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[x][i].getval()==0) ans++;
  }
  return ans;
}

void keyPressed() {
  if (key == CODED){
    if (keyCode == UP){
      keypressednow = "up";
    }
    else if (keyCode == DOWN){
      keypressednow = "down";
    } 
    else if (keyCode == LEFT){
      keypressednow = "left";
    }
    else if (keyCode == RIGHT){
      keypressednow = "right";
    }
    else {
      keypressednow = "WRONG";
    }
  }
  else {
    keypressednow = "WRONG";
  }
}

boolean allAreStill()
{
  boolean status = true;
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getxspeed() != 0 || tiles[i][j].getyspeed() !=0) status = false;
    }
  }
  return status;
}

void randomSpawn()
{
  int value;
  if(Math.random()<=0.1) value = 4;
  else value = 2;
  int empty = 0;
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getval()==0) empty++;
    }
  }
  int ans = (int)((Math.floor(Math.random()*empty))+1);
  empty = 0;
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getval()==0)
      {
        empty++;
        if(empty==ans)
        {
          tiles[i][j].setval(value);
          tiles[i][j].setFval(value);
        }
      }
    }
  }
} 

//-----------------------------------------------
//INFO
//rgb(204, 192, 180)
// line = 22 pixels
//tile = 172 pixels
//time of whole movement =  0.3 seconds for full movement across board(aka move by 3 tiles) i believe
//movement by 1 tile = 194 pixels
//6 frames = 0.1 seconds = timetomoveby1tile
