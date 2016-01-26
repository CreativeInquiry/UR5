ControlP5 cp5;

// GUI
ControlP5 cp5;
controlP5.Button b;

// GUI
int myColorBackground = color(0, 0, 0);
int buttonW = 50;
int buttonGap = 50;
int buttonH = 30;

class GuiMagic {
 void setupGui(PApplet parent) {
  // GUI
  cp5 = new ControlP5(parent);
  
  int buttonID = 1; 
  cp5.addButton("prepEncodedData")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);  
 }

  // BYTE MAGIC
  public void prepEncodedData(int theValue) {
    for (int i = 0; i < brushStrokes.size(); i++) {
      encodeData(brushStrokes.get(i));
    }  
  }

 
}
