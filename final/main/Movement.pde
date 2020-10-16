public class Movement
{
  private PVector start;
  private PVector end;
  private int value;
  private Tile t = new Tile(0.0,0.0);
  private String dir;
  boolean gone = false;
  
  public Movement(PVector start, PVector end, int value, String dir)
  {
    this.start = new PVector(((22)+194*start.x), ((22)+194*start.y));
    this.end = new PVector(((22)+194*end.x), ((22)+194*end.y));
    this.value = value;
    this.t.setcords(this.start.x,this.start.y);
    this.t.setval(value);
    this.dir = dir;
  }
  public void go()
  {
    if(!gone)
    {
    t.update();
    t.display();
    if(dir.equals("up")) t.changeycord(-194.0/6.0);
    if(dir.equals("down")) t.changeycord(194.0/6.0);
    if(dir.equals("left")) t.changexcord(-194.0/6.0);
    if(dir.equals("right")) t.changexcord(194.0/6.0);
    }
  }
  public PVector timetodie()
  {
    return this.end;
  }
  public PVector currloc()
  {
    return this.t.getcords();
  }
}
