Tile tiles[][] = new Tile[4][4];
String keypressednow = "none";
boolean justMoved;
int score = 0;
int ttlttlmoves = 0;
int dscore = 0;
boolean dead = false;
int bestscore = 0;
boolean justwon = false;

ArrayList<Movement> movers = new ArrayList<Movement>();

void setup()
{
  frameRate(60);
  size(1100,800);
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      tiles[i][j] = new Tile((22+(194*i)),(22+(194*j)));
      tiles[i][j].setval(0);
      tiles[i][j].update();
    }
  }
  //tiles[3][1].add2q(2,2);
  //tiles[2][2].add2q(2,4);
  //movers.add(0,new Movement(new PVector(1,1),new PVector(3,1),2,"right"));
  //movers.add(0,new Movement(new PVector(0,2),new PVector(2,2),4,"right"));
  randomSpawn();
  //tiles[0][0].setval(1024);
  //tiles[0][1].setval(1024);
  //tiles[0][2].setval(4);
  //tiles[0][3].setval(9182);
  //moveAllDown();
}







void draw() 
{
  
  background(182, 173, 160);
  //------------------------------------------------------------------
  //sidebar+keypressed
  fill(255);
  rect(800,0,300,800,5);
  
  fill(182, 173, 160);
  rect(850,100,200,200,5);
  
  fill(224, 212, 200);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("best score", 950, 125); 
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text(bestscore, 950, 200); 
  //----------------------------------------------------------------------
  //score
  fill(182, 173, 160);
  rect(850,400,200,200,5);
  
  fill(224, 212, 200);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("score", 950, 425); 
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(55);
  text(this.score, 950, 500); 
  //----------------------------------------------------------------------
    if(!isThereMovement() && justMoved) //some kind of just moved function
  {
    if(isItOver()) dead = true;
    if(ttlttlmoves!=0) randomSpawn();
    justMoved = false;
    this.score+=this.dscore;
    this.dscore = 0;
  }
  if(!isThereMovement() && keyPressed) 
  {
    if(keypressednow.equals("up"))
    {
      ttlttlmoves = 0;
      moveAllUp();
      justMoved = true;
    }
    if(keypressednow.equals("down"))
    {
      ttlttlmoves = 0;
      moveAllDown();
      justMoved = true;
    }
    if(keypressednow.equals("left"))
    {
      ttlttlmoves = 0;
      moveAllLeft();
      justMoved = true;
    }
    if(keypressednow.equals("right")) 
    {
      ttlttlmoves = 0;
      moveAllRight();
      justMoved = true;
    }
  }
  //----------------------------------------------------------------------
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      tiles[i][j].update();
      tiles[i][j].display();
    }
  }
  for(int i = 0;i<movers.size();i++)
  {
    //print("\n"+i+"\ndie"+movers.get(i).timetodie().x+"\nloc"+movers.get(i).currloc().x);
    if(Math.abs(movers.get(i).timetodie().x - movers.get(i).currloc().x)<=0.0001 && Math.abs(movers.get(i).timetodie().y - movers.get(i).currloc().y)<=0.0001)
    {
      movers.remove(i);
      i--;
      continue;
    }
    movers.get(i).go();
  }
  if(dead)
  {
    //print("dead\n");
    //print(this.score);
    fill(0,0,0,120);
    rect(0,0,1100,800,5);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(100);
    text("YOU DEAD BOI", 550, 200);
    textSize(50);
    text("or girl", 550, 300);
    textAlign(CENTER, CENTER);
    textSize(50);
    text(this.score, 550, 400); 
    fill(255);
    rect(350,500,400,200);
    fill(0,255,0);
    textSize(50);
    text("try again?", 550, 600);
    if (mousePressed == true) {
     fill(0,255,0);
      if(mouseX>=350 && mouseX<=750 && mouseY>=500 && mouseY<=700)
      {
        restart();
      }
    }
    else 
    {
      fill(255,0,0);
    }
    ellipse(mouseX, mouseY, 20, 20);
  }
  if(justwon)
  {
    fill(0,0,0,120);
    rect(0,0,1100,800,5);
    textAlign(CENTER, CENTER);
    textSize(100);
    fill(0);
    text("ayyyyyy", 550, 200);
    textSize(50);
    text("you won", 550, 300);
    fill(255);
    rect(350,500,175,200);
    fill(0);
    textSize(36);
    text("continue?", 437.5, 600);
    fill(255);
    rect(550,500,200,200);
    fill(0);
    textSize(50);
    text("restart?", 650, 600);
     if (mousePressed == true) {
     fill(0,255,0);
      if(mouseX>=350 && mouseX<=525 && mouseY>=500 && mouseY<=700)
      {
        this.justwon = false;
      }
    else if(mouseX>=550 && mouseX<=750 && mouseY>=500 && mouseY<=700)
    {
      restart();
    }
    }
    else 
    {
      fill(255,0,0);
    }
    ellipse(mouseX, mouseY, 20, 20);
}
}

void restart()
{
  this.tiles = new Tile[4][4];
  this.keypressednow = "none";
  this.bestscore = max(this.bestscore, this.score);
  this.score = 0;
  this.ttlttlmoves = 0;
  this.dscore = 0;
  this.dead = false;
  this.justwon = false;
  setup();
}











void moveAllRight()
{
  for(int j = 0;j<4;j++)
  {
    for(int i = 3;i>=0;i--)
    {
      if(tiles[i][j].getval()!=0)
      {
       int totalmoves = merge_horizontal_check(tiles[i][j],i,j,1) + move_horizontal_check(i,j,1);
       ttlttlmoves+= totalmoves;
       if(totalmoves!=0)
       {
         tiles[i+totalmoves][j].add2q(totalmoves,tiles[i][j].getfutureval());
         movers.add(0,new Movement(new PVector(i,j),new PVector(i+totalmoves,j),tiles[i][j].getfutureval(),"right"));
         tiles[i][j].setval(0);
       }
      }
    }
  }
  updatethescore();
}

void moveAllLeft()
{
  for(int j = 0;j<4;j++)
  {
    for(int i = 0;i<4;i++)
    {
      if(tiles[i][j].getval()!=0)
      {
       int totalmoves = merge_horizontal_check(tiles[i][j],i,j,-1) + move_horizontal_check(i,j,-1);
       ttlttlmoves +=totalmoves;
       if(totalmoves!=0)
       {
         tiles[i-totalmoves][j].add2q(totalmoves,tiles[i][j].getfutureval());
         movers.add(0,new Movement(new PVector(i,j),new PVector(i-totalmoves,j),tiles[i][j].getfutureval(),"left"));
         tiles[i][j].setval(0);
       }
      }
    }
  }
  updatethescore();
}

void moveAllUp()
{
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getval()!=0)
      {
       int totalmoves = merge_vertical_check(tiles[i][j],i,j,-1) + move_vertical_check(i,j,-1);
       ttlttlmoves+=totalmoves;
       if(totalmoves!=0)
       {
         tiles[i][j-totalmoves].add2q(totalmoves,tiles[i][j].getfutureval());
         movers.add(0,new Movement(new PVector(i,j),new PVector(i,j-totalmoves),tiles[i][j].getfutureval(),"up"));
         tiles[i][j].setval(0);
       }
      }
    }
  }
  updatethescore();
}

void moveAllDown()
{
  for(int i = 0;i<4;i++)
  {
    for(int j = 3;j>=0;j--)
    {
      if(tiles[i][j].getval()!=0)
      {
       int totalmoves = merge_vertical_check(tiles[i][j],i,j,1) + move_vertical_check(i,j,1);
       ttlttlmoves+=totalmoves;
       if(totalmoves!=0)
       {
         tiles[i][j+totalmoves].add2q(totalmoves,tiles[i][j].getfutureval());
         movers.add(0,new Movement(new PVector(i,j),new PVector(i,j+totalmoves),tiles[i][j].getfutureval(),"down"));
         tiles[i][j].setval(0);
       }
      }
    }
  }
  updatethescore();
}

int merge_horizontal_check(Tile tile,int x, int y, int direction)
{
  int ans = 0;
  for(int i = x+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[i][y].getval()!=0 && tiles[i][y].getqlength()>=1)
    { 
      break;
    }
    if(tiles[i][y].getqlength()==2)
    {
      break;
    }
    if(tiles[i][y].getfutureval()!=0 && tiles[i][y].getfutureval()!=tile.getfutureval()) break;
    if(tiles[i][y].getfutureval()==tile.getfutureval())ans++;
  }
  return ans;
}

int move_horizontal_check(int x, int y, int direction)
{
  int ans = 0;
  for(int i = x+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[i][y].getfutureval()==0) ans++;
  }
  return ans;
}

int move_vertical_check(int x, int y, int direction)
{
  int ans = 0;
  for(int i = y+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[x][i].getfutureval()==0) ans++;
  }
  return ans;
}

int merge_vertical_check(Tile tile,int x, int y, int direction)
{
  int ans = 0;
  for(int i = y+direction;i>-1 && i<4;i = i + direction)
  {
    if(tiles[x][i].getval()!=0 && tiles[x][i].getqlength()>=1)
    {
      break;
    }
    if(tiles[x][i].getqlength()==2)
    {
      break;
    }
    if(tiles[x][i].getfutureval()!=0 && tiles[x][i].getfutureval()!= tile.getfutureval()) break;
    if(tiles[x][i].getfutureval()==tile.getfutureval())ans++;
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

boolean isThereMovement()
{
  boolean status;
  if(movers.size()==0) status = false;
  else status = true;
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
        }
      }
    }
  }
} 

int nowheretogo(Tile tile, int x, int y)
{
  int totalmoves = merge_vertical_check(tile,x,y,-1) + move_vertical_check(x,y,-1) + merge_vertical_check(tile,x,y,1) + move_vertical_check(x,y,1);
  totalmoves+= merge_horizontal_check(tile,x,y,-1) + move_horizontal_check(x,y,-1) + merge_horizontal_check(tile,x,y,1) + move_horizontal_check(x,y,1);
  return totalmoves;
}

boolean isItOver()
{
  int allthemoves = 0;
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      allthemoves+=nowheretogo(tiles[i][j],i,j);
    }
  }
  if(allthemoves==0) return true;
  else return false;
}

void updatethescore()
{
  for(int i = 0;i<4;i++)
  {
    for(int j = 0;j<4;j++)
    {
      if(tiles[i][j].getqlength()==2)
      {
        this.dscore+= tiles[i][j].getfutureval();
        if(tiles[i][j].getfutureval()==2048) justwon = true;
      }
      if(tiles[i][j].getval()!=0 && tiles[i][j].getqlength()==1)
      {
        this.dscore+= tiles[i][j].getfutureval();
        if(tiles[i][j].getfutureval()==2048) justwon = true;
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
