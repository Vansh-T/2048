public class Tile
{
private int futurevalue;
private int value;
private float xcord;
private float ycord;
private color Color;
private float textxcord;
private float textycord;
private color textColor;
private ArrayList<PVector> qappears = new ArrayList<PVector>();
private int textSIZE = 75;

public Tile(float xcord, float ycord)
{
  this.xcord = xcord;
  this.ycord = ycord;
  this.textxcord = this.xcord + (172/2);
  this.textycord = this.ycord + (172/2);
  value = 0;
  Color = color(204, 192, 180);
  textColor = color(120, 110, 100);
  this.textSIZE = 75;
}

public void setcords(float x, float y)
{
  this.xcord = x;
  this.ycord = y;
}
public void changexcord(float x)
{
  this.xcord += x;
}
public void changeycord(float y)
{
  this.ycord += y;
}

public PVector getcords()
{
  PVector a = new PVector(this.xcord,this.ycord);
  return a;
}

public void setval(int val)
{
  this.value = val;
}
public int getqlength()
{
  return qappears.size();
}
public void add2q(int moveLength, int value)
{
  int time = 6*moveLength;
  PVector p = new PVector(time,value);
  this.qappears.add(p);
}

public int getval()
{
  return this.value;
}

public void update()
{
  //time val updater
  setColor(); 
  this.textxcord = this.xcord + (172/2);
  this.textycord = this.ycord + (172/2);
  for(int i = 0;i<qappears.size();i++)
  {
    this.qappears.get(i).x--;
    if(this.qappears.get(i).x==0) 
    {
      this.value+=this.qappears.get(i).y;
      this.qappears.remove(i);
      i--;
    }
  }
}
public void display()
{
  noStroke();
  fill(Color);
  rect(this.xcord,this.ycord,172,172,5);
  if(this.value!=0)
  {
  fill(textColor);
  textAlign(CENTER, CENTER);
  textSize(this.textSIZE);
  text(value, this.textxcord, this.textycord);  
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
  if(this.value == 32) this.Color = color(247, 123, 95);
  if(this.value == 64) this.Color = color(234, 90, 56);
  if(this.value == 128) this.Color = color(236, 207, 113);
  if(this.value == 256) this.Color = color(242, 208, 75);
  if(this.value == 512) this.Color = color(236, 200, 79);
  if(this.value == 1024) this.Color = color(227, 186, 20);
  if(this.value == 2048) this.Color = color(227, 186, 20);
  if(this.value>2048) this.Color = color(103, 56, 255);
  if(this.value>512) this.textSIZE = 70;
}
public int getfutureval()
{
  int ans = this.value;
  for(PVector a:qappears)
  {
    ans+=a.y;
  }
  return ans;
}
}
