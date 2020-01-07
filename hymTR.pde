// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
//import peasy.*;


public void setup(){
  size(480, 500, JAVA2D);
  createGUI();
  delay(5000);
  customGUI();
  delay(5000);
  

  // Place your setup code here
  
}

public void draw(){
  background(200,150,150);
  
}

public void oncloseSeriportWindow(GWindow window) { //_CODE_:seriportWindow:346375:
  println("seriportWindow - window closed at " + millis());
} //_CODE_:seriportWindow:346375:


// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  seriportWindow = GWindow.getWindow(this, "Seri Port Secimi", 0, 0, 240, 240, JAVA2D);
  seriportWindow.noLoop();
//  seriportWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  seriportWindow.addDrawHandler(this, "win_draw2");
  seriportWindow.addPreHandler(this, "preSeriportWindow");
  seriportWindow.addPostHandler(this, "postSeriportWindow");
  seriportWindow.addOnCloseHandler(this, "oncloseSeriportWindow");
//    buttonBaglan.addEventHandler(this, "buttonBaglanClick");
  buttonBaglan = new GButton(seriportWindow, 74, 204, 80, 30);
  buttonBaglan.setText("Baglan");
  buttonBaglan.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  label2 = new GLabel(seriportWindow, 20, 20, 210, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Baglanti Noktasi (port)");
  label2.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  label2.setOpaque(false);

  seriportWindow.loop();
  seriportWindow.close();
  

}
