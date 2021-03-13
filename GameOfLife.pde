import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public class Sketch extends PApplet {

  // Declare and initialize constants NUM_ROWS and NUM_COLS = 20
  public final static int NUM_ROWS = 20;
  public final static int NUM_COLS = 20;
  private Life[][] buttons; // 2d array of Life buttons each representing one cell
  private boolean[][] buffer = new boolean [NUM_ROWS][NUM_COLS]; // 2d array of booleans to store state of buttons array
  private boolean running = true; // used to start and stop program

  public void settings() {
    size(400, 400);
  }

  public void setup() {

    frameRate(6);
    // make the manager
    Interactive.make(this);
    buttons = new Life[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        buttons[r][c] = new Life(r, c);
      }
    }

  }

  public void draw() {
    background(0);
    if (running == false) // pause the program
      return;
    copyFromButtonsToBuffer();

    // use nested loops to draw the buttons here
    for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        if(countNeighbors(r,c) == 3){
          buffer[r][c] = true;
        }else{
          if(buttons[r][c].getLife() == true && countNeighbors(r,c) == 2){
            buffer[r][c] = true;
          }else{
            buffer[r][c] = false;
          }
        }
        buttons[r][c].draw();
      }
    }

    copyFromBufferToButtons();
  }

  public void keyPressed() {
    if (running = false){
      running = true;
    }else{
      running = false;
    }
  }

  public void copyFromBufferToButtons() {
    for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        if(buffer[r][c] == true){
          buttons[r][c].setLife(true);
        }else{
          buttons[r][c].setLife(false);
        }
      }
    }
  }


  public void copyFromButtonsToBuffer() {
  for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        if(buttons[r][c].equals(true)){
          buffer[r][c] = true;
        }else{
          buffer[r][c] = false;
        }
      }
    }
  }

  public boolean isValid(int r, int c) {
    if(r >= 0 && r <= 19 && c >= 0 && c <= 19){
      return true;
    }
    return false;
  }

  public int countNeighbors(int row, int col) {
    int neighbors = 0;

    //upperleft
    if(isValid(row-1, col-1) == true){
      if(buttons[row-1][col-1].getLife() == true){
        neighbors++;
      }
    }

    //uppermiddle
    if(isValid(row-1, col) == true){
      if (buttons[row-1][col].getLife() == true){
        neighbors++;
      }
    }
    //upperright
    if(isValid(row-1, col+1) == true){
    if (buttons[row-1][col+1].getLife() == true){
      neighbors++;
    }
    }

    //middleright
    if(isValid(row, col+1) == true){
    if (buttons[row][col+1].getLife() == true){
      neighbors++;
    }
    }
    //bottomright
    if(isValid(row+1, col+1) == true){
    if (buttons[row+1][col+1].getLife() == true){
      neighbors++;
    }
    }
    //bottommiddle
    if(isValid(row+1, col) == true){
    if (buttons[row+1][col].getLife() == true){
      neighbors++;
    }
    }
    //bottomleft
    if(isValid(row+1, col-1) == true){
    if (buttons[row+1][col-1].getLife() == true){
      neighbors++;
    }
    }
    //bottommiddleleft
    if(isValid(row, col-1) == true){
    if (buttons[row][col-1].getLife() == true){
      neighbors++;
    }
    }
    return neighbors;
  }

  public class Life {
    private int myRow, myCol;
    private float x, y, width, height;
    private boolean alive;

    public Life(int row, int col) {
      width = 400 / NUM_COLS;
      height = 400 / NUM_ROWS;
      myRow = row;
      myCol = col;
      x = myCol * width;
      y = myRow * height;
      alive = Math.random() < .5; // 50/50 chance cell will be alive
      Interactive.add(this); // register it with the manager
    }

    // called by manager
    public void mousePressed() {
      alive = !alive;
      // turn cell on and off with mouse press
    }

    public void draw() {
      if (alive != true)
        fill(0);
      else
        fill(51,153,255);
      rect(x, y, width, height);
    }

    public boolean getLife() {
      // replace the code one line below with your code
      if(alive == true){
        return true;
      }
      return false;
    }

    public void setLife(boolean living) {
      alive = living;
    }
  }
}
