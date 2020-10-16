public class Tile
{
private int value;
private int x;
private int y;
private float xcord;
private float ycord;
private color Color;
private float textxcord;
private float textycord;
private color textColor;
private float xspeed;
private float yspeed;
private int distleft;
private boolean isBack;
private int futureVal;

public Tile()
{
  value = 0;
  x = 0;
  y = 0;
  Color = color(204, 192, 180);
  textColor = color(120, 110, 100);
  xspeed = 0;
  yspeed = 0;
  distleft = 0;
  isBack = false;
  futureVal = 0;
}

public Tile(int x, int y)
{
  this.x = x;
  this.y = y;
  this.xcord = 22+(194*this.x);
  this.ycord = 22+(194*this.y);
  xspeed = 0;
  yspeed = 0;
  distleft = 0;
  isBack = false;
  futureVal = 0;
}

//public void setSleeper

public Tile clone()
{
  Tile copy = new Tile();
  copy.setval(this.value);
  copy.setcords(this.xcord,this.ycord);
  copy.setFval(this.futureVal);
  return copy;
}

public void setback()
{
  this.isBack = true;
}

public void moveRight(int horizontalCheckResults)
{
  if(this.value!=0)
  {
  this.distleft = horizontalCheckResults;
  this.distleft = (this.distleft*6)+1;
  this.xspeed = 194.0/6.0;
  }
}

public void moveLeft(int horizontalCheckResults)
{
  if(this.value!=0)
  {
  this.distleft = horizontalCheckResults;
  this.distleft = (this.distleft*6)+1;
  this.xspeed = -194.0/6.0;
  }
}

public void moveUp(int verticalCheckResults)
{
  if(this.value!=0)
  {
  this.distleft = verticalCheckResults;
  this.distleft = (this.distleft*6)+1;
  this.yspeed = -194.0/6.0;
  }
}

public void moveDown(int verticalCheckResults)
{
  if(this.value!=0)
  {
  this.distleft = verticalCheckResults;
  this.distleft = (this.distleft*6)+1;
  this.yspeed = 194.0/6.0;
  }
}

public float getxspeed()
{
  return this.xspeed;
}
public float getyspeed()
{
  return this.yspeed;
}

public void setxy(int x, int y)
{
  this.x = x;
  this.y = y;
}

public int getx()
{
  return this.x;
}

public int gety()
{
  return this.y;
}

public void setval(int val)
{
  this.value = val;
}

public void setFval(int fval)
{
  this.futureVal = fval;
}

public int getFval()
{
  return this.futureVal;
}

public int getval()
{
  return this.value;
}

public void update()
{
  this.textxcord = this.xcord + (172/2);
  this.textycord = this.ycord + (172/2);
  setColor();
  if(this.distleft!=0)
  {
    this.distleft -=1;
  }
  if(this.distleft == 0)
  {
    this.xspeed = 0;
    this.yspeed = 0;
  }
  this.xcord += this.xspeed;
  this.ycord += this.yspeed;
  if(this.xspeed == 0 && this.yspeed==0) this.value = this.futureVal;
  
}
public void display()
{
  if(isBack)
  {
  noStroke();
  fill(Color);
  rect(this.xcord,this.ycord,172,172,5);
  }
  if(!isBack)
  {
  if(value!=0)
  {
  noStroke();
  fill(Color);
  rect(this.xcord,this.ycord,172,172,5);
  fill(textColor);
  textAlign(CENTER, CENTER);
  textSize(75);
  text(value, this.textxcord, this.textycord); 
  } 
  }
}
public void setColor()
{
  if(this.value<=4)
  {
    this.textColor = color(120, 110, 100);
  }
  else
  {
    this.textColor = color(255);
  }
  if(this.value==0) this.Color = color(204, 192, 180);
  if(this.value == 2) this.Color = color(238, 228, 218);
  if(this.value == 4) this.Color = color(236, 224, 202);
  if(this.value == 8) this.Color = color(242, 177, 121);
  if(this.value == 16) this.Color = color(236, 141, 83);
  //if(this.value == 32) this.Color = color(238, 228, 218);
  //if(this.value == 64) this.Color = color(238, 228, 218);
  //if(this.value == 128) this.Color = color(238, 228, 218);
  //if(this.value == 256) this.Color = color(238, 228, 218);
  //if(this.value == 512) this.Color = color(238, 228, 218);
  //if(this.value == 1024) this.Color = color(238, 228, 218);
  //if(this.value == 2048) this.Color = color(238, 228, 218);
}

public void setcords(float xcord, float ycord)
{
  this.xcord = xcord;
  this.ycord = ycord;
}

public void setSpeed(float xspeed, float yspeed)
{
  this.xspeed = xspeed;
  this.yspeed = yspeed; 
}

}
