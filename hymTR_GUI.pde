// Need G4P library
import g4p_controls.*;
import processing.serial.*;
Serial myPort;

String SeriJSON = "";
boolean yeniVeri = false;
boolean veriBasi = false;
boolean gondermeAktif = false;

String Versiyon = "01012020a";

public class APRS_Ayarlari {
  String[] APRS_CagriIsareti;
  char APRS_CagriIsaretiSSID;
  String[] APRS_Destination;
  char APRS_DestinationSSID;  
  String[] APRS_Path1;
  char APRS_Path1SSID;
  String[] APRS_Path2;
  char APRS_Path2SSID;
  char APRS_Sembolu;
  char APRS_SembolTabi;
  byte APRS_BeaconTipi;    //0=sure beklemeli, 1=Smart Beacon
  long APRS_BeaconSuresi;
  long  APRS_GPSSeriHizi;    
  String[] APRS_Mesaj;
  long CheckSum;    //Cagri isaretinin byte toplamini kullaniyoruz
};


public void setup(){
  size(460, 500, JAVA2D);
  splashGUI();
  createMainGUI();
  
  timer1 = new GTimer(this, this, "timer1_Action1", 5000);
  timer1.start(1);
}

public void draw(){
  background(230,230,230);

  
  if ( myPort != null && !gondermeAktif)
  {
    while (myPort.available() > 0) {
    int inByte = myPort.read();
    if (inByte == '{') {println(); SeriJSON = ""; veriBasi = true;}
    if (veriBasi && inByte != '>' ) SeriJSON += (char)inByte;
    print((char)inByte);
    if (inByte == '}') { println(); yeniVeri = true; veriBasi=false;}
    }
  }
  
  if (yeniVeri) 
  {
   //TODO: Ekrani doldur
//{'V':'01012020a','CagriIsareti':'TAMSAT','CagriIsaretiSSID':9,'Destination':'APRS  ','DestinationSSID':0,'Path1':'WIDE1 ','Path1SSID':1,'Path2':'WIDE2 ','Path2SSID':1,'Sembol':'','SembolTabi':'A','BeaconTipi':3,'BeaconSuresi':255,'Mesaj':'TAMSAT hymTR APRS Tracker','GPSHizi':9600}
  JSONObject json = parseJSONObject(SeriJSON);
  if (json == null) {
    println("Veri Cozumlenemedi");
  } else {
    textfieldCagriAdi.setText(json.getString("CagriIsareti"));
    
    if (json.getInt("CagriIsaretiSSID") == 0) dropListSSID.setSelected(0);
    if (json.getInt("CagriIsaretiSSID") == 7) dropListSSID.setSelected(1);
    if (json.getInt("CagriIsaretiSSID") == 9) dropListSSID.setSelected(2);
    
    if (json.getString("Sembol") == "-") dropListSembol.setSelected(0); //ev
    if (json.getString("Sembol") == "<") dropListSembol.setSelected(2); //motorsiklet
    if (json.getString("Sembol") == ">") dropListSembol.setSelected(3); //araba
    
    textfieldMesaj.setText(json.getString("Mesaj"));
    

  }
  yeniVeri = false;  
  }
  
  
} // draw()

public void timer1_Action1(GTimer source) { //_CODE_:timer1:910330:
  println("timer1 - GTimer >> an event occured @ " + millis());
  splashScreen.forceClose();
} //_CODE_:timer1:910330:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:seriportWindow:303233:
  appc.background(230);
} //_CODE_:seriportWindow:303233:

synchronized public void preSeriportWindow(PApplet appc, GWinData data) { //_CODE_:seriportWindow:982297:
//  println("seriportWindow - pre method called " + millis());
} //_CODE_:seriportWindow:982297:

synchronized public void postSeriportWindow(PApplet appc, GWinData data) { //_CODE_:seriportWindow:981943:
//  println("seriportWindow - post method called " + millis());
} //_CODE_:seriportWindow:981943:

public void oncloseSeriportWindow(GWindow window) { //_CODE_:seriportWindow:346375:
//  println("seriportWindow - window closed at " + millis());
} //_CODE_:seriportWindow:346375:

public void buttonBaglanClick(GButton source, GEvent event) { //_CODE_:buttonBaglan:635785:
//  println("buttonBaglan - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonBaglan:635785:

public void imgButton3_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsat:765992:
//  println("imgButton3 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsat:765992:

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:splashScreen:721218:
  appc.background(230);
} //_CODE_:splashScreen:721218:

public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsatLogo:646942:
//  println("imgButton1 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsatLogo:646942:

public void imgButton2_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsatInfo:450767:
//  println("imgButton2 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsatInfo:450767:

public void checkboxLokasyon_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxLokasyon:939952:
//  println("checkboxLokasyon - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxLokasyon:939952:

public void checkboxYukseklik_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxYukseklik:919125:
//  println("checkbox2 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxYukseklik:919125:

public void sliderZamanlama_change1(GSlider source, GEvent event) { //_CODE_:sliderZamanlama:300012:
//  println("sliderZamanlama - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderZamanlama:300012:

public void checkboxBatarya_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxBatarya:493573:
//  println("checkboxBatarya - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxBatarya:493573:

/* 
 * Programda ayarlanan degerlerin seri porttan Tracker a gonderilmesi 
 */
public void buttonSend_click1(GButton source, GEvent event) { //_CODE_:buttonSend:872700:
//  println("buttonSend - GButton >> GEvent." + event + " @ " + millis());
  gondermeAktif = true;
   myPort.write('!'); // Seri porttan Tracker'a bilgileri gonder
   delay(2000);
   myPort.write('W'); // Seri porttan Tracker'a bilgileri gonder
   delay(2000);
   myPort.write(0x01);
   myPort.write(Versiyon);
   myPort.write(0x09);
   myPort.write(textfieldCagriAdi.getText());                       // Cagri ISareti
   myPort.write(0x09);
   if (dropListSSID.getSelectedIndex() == 0) myPort.write("0");    //SSID 0
   if (dropListSSID.getSelectedIndex() == 1) myPort.write("7");    //SSID 7 
   if (dropListSSID.getSelectedIndex() == 2) myPort.write("9");    //SSID 9
   myPort.write(0x09);
   //TODO: Destination, Path1, Path2 buraya kjoyulabilir
   if (dropListSembol.getSelectedIndex() == 0) myPort.write("-");  //Sembol
   if (dropListSembol.getSelectedIndex() == 1) myPort.write("<");  //Sembol
   if (dropListSembol.getSelectedIndex() == 2) myPort.write(">");  //Sembol
   myPort.write(0x09);
   myPort.write('/'); //Sembol Tabi
   myPort.write(0x09);
   myPort.write("1");  //Beacon Tipi
   myPort.write(0x09);
   myPort.write("60");  //Beacon Suresi  //TODO: ekrandan al
   myPort.write(0x09);
   myPort.write(textfieldMesaj.getText()); //Mesaj
   myPort.write(0x09);
   myPort.write("9600");  //GPS Hizi  //TODO: ekrandan GPS hizini listeden alip gonder

  gondermeAktif = false;
  //myPort.write('P');
} //_CODE_:buttonSend:872700:

public void textfieldCagriAdi_change1(GTextField source, GEvent event) { //_CODE_:textfieldCagriAdi:558481:
//  println("textfieldCagriAdi - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldCagriAdi:558481:

public void dropListSeriPort_click1(GDropList source, GEvent event) {
//  println("dropListSeriPort - GDropList >> GEvent." + event + " @ " + millis());
  myPort = new Serial(this, source.getSelectedText(), 115200);
  delay(5000);
  myPort.write('!');
}

public void dropListSSID_click1(GDropList source, GEvent event) { //_CODE_:dropListSSID:560365:
//  println("dropListSSID - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSSID:560365:

public void dropListSembol_click1(GDropList source, GEvent event) { //_CODE_:dropListSembol:606061:
//  println("dropListSembol - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSembol:606061:

public void dropListGPSHizi_click1(GDropList source, GEvent event) { //_CODE_:dropListGPSHizi:549444:
//  println("dropListGPSHizi - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListGPSHizi:549444:

public void textfieldMesaj_change1(GTextField source, GEvent event) { //_CODE_:textfieldMesaj:236196:
//  println("textfieldMesaj - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldMesaj:236196:

public void sliderPreamble_change1(GSlider source, GEvent event) { //_CODE_:sliderPreamble:934008:
//  println("sliderPreamble - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderPreamble:934008:

public void sliderTXDelay_change1(GSlider source, GEvent event) { //_CODE_:sliderTXDelay:750989:
//  println("sliderTXDelay - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderTXDelay:750989:

public void buttonReceive_click1(GButton source, GEvent event) { //_CODE_:buttonReceive:300015:
//  println("buttonReceive - GButton >> GEvent." + event + " @ " + millis());
  myPort.write('!'); // Seri porttan Tracker bilgilerini Oku
  delay(1000);
  myPort.write('R'); // Seri porttan Tracker bilgilerini Oku
} //_CODE_:buttonReceive:300015:

public void splashGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GOLD_SCHEME);
  G4P.setMouseOverEnabled(false);
  splashScreen = GWindow.getWindow(this, "hymTR APRS Tracker", 0, 0, 420, 200, JAVA2D);
  splashScreen.noLoop();
  splashScreen.setActionOnClose(G4P.CLOSE_WINDOW);
  splashScreen.addDrawHandler(this, "win_draw1");
  imgButtonTamsatLogo = new GImageButton(splashScreen, 15, 15, 70, 70, new String[] { "TAMSATLOGOBUYUK.png", "TAMSATLOGOBUYUK.png", "TAMSATLOGOBUYUK.png" } );
  imgButtonTamsatLogo.addEventHandler(this, "imgButton1_click1");
  imgButtonTamsatInfo = new GImageButton(splashScreen, 80, 12, 340, 80, new String[] { "tamsatbuyuklogoen.png", "tamsatbuyuklogoen.png", "tamsatbuyuklogoen.png" } );
  imgButtonTamsatInfo.addEventHandler(this, "imgButton2_click1");
  labelProgramAdi = labelFn(splashScreen, "hymTR APRS Tracker", 80, 85, 270, 30);
  labelProgramAdi.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  hazirlayanlar = labelFn(splashScreen, "HAZIRLAYANLAR", 160, 125, 120, 20);
  baris = labelFn(splashScreen,"Baris DINC\n  (TA7W)", 50, 150, 80, 30);
  burcu = labelFn(splashScreen, "Burcu AYBAK\n  (TA2NBA)", 170, 150, 90, 30);
  emre = labelFn(splashScreen, "Emre KELES\n (TA6AUE)", 290, 150, 80, 30);

  splashScreen.loop();
}

public void createMainGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GOLD_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("hymTR Ayar Programi (v01012020a)");
  String[] seriPortListesi = Serial.list();
  String[] ssidListesi = {"-0 Sabit Merkez","-7 El Telsizi ile hareketli","-9 Mobil arac"};
  String[] semboller = {"Ev","Motorsiklet","Araba"};
  String[] gpsHizlari = {"4800","9600","57600","115200"};
  
  labelSeriPort = labelFn(this, "Seri Port", 20, 10, 80, 20);
  dropListSeriPort = dropListFn(seriPortListesi, "dropListSeriPort_click1", 99, 10, 351, 80, 3, 10);
  labelCagriAdi = labelFn(this, "Cagriadi", 20, 40, 80, 20);
  textfieldCagriAdi = textFieldFn("TA7W", "textfieldCagriAdi_change1", 99, 40, 150, 20, G4P.SCROLLBARS_NONE);
  labelSSID = labelFn(this, "SSID", 253, 40, 36, 20);
  dropListSSID = dropListFn(ssidListesi, "dropListSSID_click1", 290, 40, 160, 80, 3, 10);
  labelSembol = labelFn(this, "Sembol", 20, 70, 80, 20);
  dropListSembol = dropListFn(semboller, "dropListSembol_click1", 100, 70, 150, 80, 3, 10);
  labelGPS = labelFn(this, "GPS", 20, 100, 80, 20);
  radioButtonGPSVar = radioButtonFn("Var", "radioButtonGPSVar_clicked1", false, 100, 100, 50, 20);
  radioButtonGPSYok = radioButtonFn("Yok", "radioButtonGPSYok_clicked1", false, 160, 100, 50, 20);
  labelGPSPortHizi = labelFn(this, "GPS Port Hizi", 250, 100, 80, 20);
  dropListGPSHizi = dropListFn(gpsHizlari, "dropListGPSHizi_click1", 330, 100, 120, 80, 4, 10);
  labelMesaj = labelFn(this, "Mesaj", 20, 130, 80, 20);
  textfieldMesaj = textFieldFn("QRV 145.500 Ceptel: 0 5XX XXX XX XX", "textfieldMesaj_change1", 100, 130, 350, 20, G4P.SCROLLBARS_NONE);
  labelGonder = labelFn(this, "Gonder", 20, 160, 80, 20);
  checkboxLokasyon = checkboxFn("Lokasyon", "checkboxLokasyon_clicked1", true, 100, 160, 150, 20);
  checkboxYukseklik = checkboxFn("Yukseklik", "checkboxYukseklik_clicked1", false, 100, 180, 150, 20);
  checkboxBatarya = checkboxFn("Batarya Durumu", "checkboxBatarya_clicked1", false, 100, 200, 150, 20);
  labelAkilliBeacon = labelFn(this, "Akilli Beacon (Dakika)", 10, 220, 180, 20);
  sliderZamanlama = sliderFn(1, 1, 60, 10, "sliderZamanlama_change1", 10, 240, 440, 47, 10.0);
  labelPreambleSuresi = labelFn(this, "Preamble Suresi (milisaniye)", 10, 300, 180, 20);
  sliderPreamble = sliderFn(350, 100, 1000, 20, "sliderPreamble_change1", 10, 320, 440, 50, 10.0);
  labelKuyrukSuresi = labelFn(this, "Kuyruk Suresi (milisaniye)", 10, 380, 190, 20);
  sliderTXDelay = sliderFn(100, 50, 500, 9, "sliderTXDelay_change1", 10, 400, 440, 50, 10.0);
  buttonReceive = buttonFn("Bilgileri Cihazdan Al", "buttonReceive_click1", 10, 460, 210, 30);
  buttonSend = buttonFn("Bilgileri Cihaza Yukle", "buttonSend_click1", 229, 460, 220, 30);
}

public GLabel labelFnT(PApplet theApplet, String name, float leftMargin, float topMargin, float itemSizeX, float itemSizeY) {
  GLabel genLabel;
  genLabel = new GLabel(theApplet, leftMargin, topMargin, itemSizeX, itemSizeY);
  genLabel.setText(name);
  genLabel.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genLabel.setOpaque(false);
  return genLabel;
}

public GLabel labelFn(PApplet theApplet, String name, float leftMargin, float topMargin, float itemSizeX, float itemSizeY) {
  GLabel genLabel;
  genLabel = new GLabel(theApplet, leftMargin, topMargin, itemSizeX, itemSizeY);
  genLabel.setText(name);
  genLabel.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genLabel.setOpaque(false);
  return genLabel;
}

public GDropList dropListFn(String[] content, String controlFn, float leftMargin, float topMargin, float itemSizeX, float itemSizeY, int listSize, float buttonWidth) {
  GDropList genDropList;
  genDropList = new GDropList(this, leftMargin, topMargin, itemSizeX, itemSizeY, listSize, buttonWidth);
  genDropList.setItems(content, 3);
  genDropList.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genDropList.addEventHandler(this, controlFn);
  return genDropList;
}

public GTextField textFieldFn(String textVal, String controlFn, float leftMargin, float topMargin, float itemSizeX, float itemSizeY, int sbPolicy) {
  GTextField genTextField;
  genTextField = new GTextField(this, leftMargin, topMargin, itemSizeX, itemSizeY, sbPolicy);
  genTextField.setText(textVal);
  genTextField.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genTextField.setOpaque(true);
  genTextField.addEventHandler(this, controlFn);
  return genTextField;
}

public GOption radioButtonFn(String definition, String controlFn, Boolean isSelected, float leftMargin, float topMargin, float itemSizeX, float itemSizeY) {
  GOption genRadioButton;
  genRadioButton = new GOption(this, leftMargin, topMargin, itemSizeX, itemSizeY);
  genRadioButton.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  genRadioButton.setText(definition);
  genRadioButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genRadioButton.setOpaque(true);
  genRadioButton.addEventHandler(this, controlFn);
  genRadioButton.setSelected(isSelected);
  return genRadioButton;
}

public GCheckbox checkboxFn(String definition, String controlFn, Boolean isSelected, float leftMargin, float topMargin, float itemSizeX, float itemSizeY) {
  GCheckbox genCheckbox;
  genCheckbox = new GCheckbox(this, leftMargin, topMargin, itemSizeX, itemSizeY);
  genCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  genCheckbox.setText(definition);
  genCheckbox.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genCheckbox.setOpaque(true);
  genCheckbox.addEventHandler(this, controlFn);
  genCheckbox.setSelected(isSelected);
  return genCheckbox;
}

public GSlider sliderFn(int limit1, int limit2, int limit3, int ticks, String controlFn, float leftMargin, float topMargin, float itemSizeX, float itemSizeY, float slWidth) {
  GSlider genSlider;
  genSlider = new GSlider(this, leftMargin, topMargin, itemSizeX, itemSizeY, slWidth);
  genSlider.setShowValue(true);
  genSlider.setShowLimits(true);
  genSlider.setLimits(limit1, limit2, limit3);
  genSlider.setNbrTicks(ticks);
  genSlider.setStickToTicks(true);
  genSlider.setShowTicks(true);
  genSlider.setNumberFormat(G4P.INTEGER, 0);
  genSlider.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genSlider.setOpaque(true);
  genSlider.addEventHandler(this, controlFn);
  return genSlider;
}

public GButton buttonFn(String definition, String controlFn, float leftMargin, float topMargin, float itemSizeX, float itemSizeY){
  GButton genButton;
  genButton = new GButton(this, leftMargin, topMargin, itemSizeX, itemSizeY);
  genButton.setText(definition);
  genButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  genButton.addEventHandler(this, controlFn);
  return genButton;
}







// Variable declarations 
// splashScreen variables
GWindow splashScreen;
GImageButton imgButtonTamsatLogo; 
GImageButton imgButtonTamsatInfo; 
GLabel labelProgramAdi; 
GLabel baris; 
GLabel burcu; 
GLabel hazirlayanlar; 
GLabel emre; 
GLabel labelAciklama;

// mainScreen variables
GLabel labelSeriPort; 
GLabel labelCagriAdi; 
GLabel labelSSID; 
GLabel labelSembol;
GLabel labelGPS;
GLabel labelGPSPortHizi; 
GLabel labelMesaj; 
GLabel labelGonder; 
GLabel labelAkilliBeacon; 
GLabel labelPreambleSuresi; 
GLabel labelKuyrukSuresi;
GOption radioButtonGPSVar;
GOption radioButtonGPSYok;
GTextField textfieldCagriAdi; 
GTextField textfieldMesaj; 
GCheckbox checkboxLokasyon; 
GCheckbox checkboxYukseklik; 
GCheckbox checkboxBatarya; 
GDropList dropListSeriPort; 
GDropList dropListSSID; 
GDropList dropListSembol; 
GDropList dropListGPSHizi; 
GSlider sliderZamanlama; 
GSlider sliderPreamble; 
GSlider sliderTXDelay; 
GButton buttonReceive; 
GButton buttonSend; 
GTimer timer1;
