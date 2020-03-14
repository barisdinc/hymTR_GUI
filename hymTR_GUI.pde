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
  //{'V':'01012020a','CagriIsareti':'TAMSAT','CagriIsaretiSSID':9,'Destination':'APRS  ','DestinationSSID':0,'Path1':'WIDE1 ','Path1SSID':1,'Path2':'WIDE2 ','Path2SSID':1,'Sembol':'','SembolTabi':'A','BeaconTipi':3,'BeaconSuresi':255,'Mesaj':'TAMSAT iZCi hymTR APRS Tracker','GPSHizi':9600}
    JSONObject json = parseJSONObject(SeriJSON);
    if (json == null) {
      println("Veri Cozumlenemedi");
    } else {
      textfieldCagriAdi.setText(json.getString("CagriIsareti"));
      
      if (json.getInt("CagriIsaretiSSID") == 0) dropListSSID.setSelected(0);
      if (json.getInt("CagriIsaretiSSID") == 7) dropListSSID.setSelected(1);
      if (json.getInt("CagriIsaretiSSID") == 9) dropListSSID.setSelected(2);
      
      if (json.getString("Sembol").equals("-")) dropListSembol.setSelected(0); //ev
      if (json.getString("Sembol").equals("<")) dropListSembol.setSelected(2); //motorsiklet
      if (json.getString("Sembol").equals(">")) dropListSembol.setSelected(3); //araba
      
      textfieldMesaj.setText(json.getString("Mesaj"));
      sliderZamanlama.setValue(json.getInt("BeaconSuresi"));
    }
    yeniVeri = false;  
    labelStatusMesaj.setText("Veriler Okundu");

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

public void radioButtonGPSVar_clicked1(GOption source, GEvent event) { //_CODE_:checkboxLokasyon:939952:
  radioButtonGPSVar.setSelected(true);
  radioButtonGPSYok.setSelected(false);
//  labelGPSPortHizi.setVisible(true);
//  dropListGPSHizi.setVisible(true);
  labelLatitude.setVisible(false);
  textfieldLatitude.setVisible(false);
  labelLongitude.setVisible(false);
  textfieldLongitude.setVisible(false);
  labelAltitude.setVisible(false);
  textfieldAltitude.setVisible(false);
  println("checkboxGPS - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxLokasyon:939952:

public void radioButtonGPSYok_clicked1(GOption source, GEvent event) { //_CODE_:checkboxLokasyon:939952:
  radioButtonGPSVar.setSelected(false);
  radioButtonGPSYok.setSelected(true);
//  labelGPSPortHizi.setVisible(false);
//  dropListGPSHizi.setVisible(false);
  labelLatitude.setVisible(true);
  textfieldLatitude.setVisible(true);
  labelLongitude.setVisible(true);
  textfieldLongitude.setVisible(true);
  labelAltitude.setVisible(true);
  textfieldAltitude.setVisible(true);
  println("checkboxGPS - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxLokasyon:939952:

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

public void textfieldLatitude_change1(GTextField textfield, GEvent event) { /* code */ }

public void textfieldLongitude_change1(GTextField textfield, GEvent event) { /* code */ }

public void textfieldAltitude_change1(GTextField textfield, GEvent event) { /* code */ }
/* 
 * Programda ayarlanan degerlerin seri porttan Tracker a gonderilmesi 
 */
public void buttonSend_click1(GButton source, GEvent event) { //_CODE_:buttonSend:872700:
   labelStatusMesaj.setText("Veriler gonderiliyor...");
   gondermeAktif = true;
   myPort.write('!');                                                    // Seri porttan Tracker'a bilgileri gonder
   delay(2000);
   myPort.write('W');                                                    // Seri porttan Tracker'a bilgileri gonder
   delay(2000);
   myPort.write(0x01);
   myPort.write(Versiyon);
   myPort.write(0x09);
   myPort.write(textfieldCagriAdi.getText());                            //Cagri ISareti
   myPort.write(0x09);
   if (dropListSSID.getSelectedIndex() == 0) myPort.write("0");          //SSID 0
   if (dropListSSID.getSelectedIndex() == 1) myPort.write("7");          //SSID 7 
   if (dropListSSID.getSelectedIndex() == 2) myPort.write("9");          //SSID 9
   myPort.write(0x09);
   myPort.write("iZCi  ");                                               //Destination
   myPort.write(0x09);
   myPort.write("0");                                                    //DestinationSSID
   myPort.write(0x09);
   myPort.write("WIDE1 ");                                               //Path1
   myPort.write(0x09);
   myPort.write("1");                                                    //Path1SSID
   myPort.write(0x09);
   myPort.write("WIDE2 ");                                               //Path2
   myPort.write(0x09);
   myPort.write("1");                                                    //Path2SSID
   myPort.write(0x09);
   if (dropListSembol.getSelectedIndex() == 0) myPort.write("-");        //Sembol
   if (dropListSembol.getSelectedIndex() == 1) myPort.write("<");        //Sembol
   if (dropListSembol.getSelectedIndex() == 2) myPort.write(">");        //Sembol
   myPort.write(0x09);
   myPort.write('/');                                                    //Sembol Tabi
   myPort.write(0x09);
   myPort.write("1");                                                    //Beacon Tipi
   myPort.write(0x09);
   myPort.write(sliderZamanlama.getValueS());                       //Beacon Suresi
   myPort.write(0x09);
   //if (dropListGPSHizi.getSelectedIndex() == 0) myPort.write("4800");    //GPS Hizi
   //if (dropListGPSHizi.getSelectedIndex() == 1) myPort.write("9600");    //GPS Hizi
   myPort.write("9600");    //GPS Hizi
   //if (dropListGPSHizi.getSelectedIndex() == 2) myPort.write("57600");   //GPS Hizi
   //if (dropListGPSHizi.getSelectedIndex() == 3) myPort.write("115200");  //GPS Hizi
   myPort.write(0x09);
   myPort.write(textfieldMesaj.getText());                               //Mesaj
   myPort.write(0x09);
   if (radioButtonGPSVar.isSelected()) myPort.write("1");                //GPS Var
   if (radioButtonGPSYok.isSelected()) myPort.write("0");                //GPS Yok
   myPort.write(0x09);
   //if (checkboxLokasyon.isSelected() && !checkboxYukseklik.isSelected() && !checkboxBatarya.isSelected()) myPort.write("1");         //Lokasyon
   //if (checkboxLokasyon.isSelected() && checkboxYukseklik.isSelected() && !checkboxBatarya.isSelected()) myPort.write("2");          //Lokasyon
   //if (checkboxLokasyon.isSelected() && checkboxYukseklik.isSelected() && checkboxBatarya.isSelected()) myPort.write("4");           //Lokasyon
   //myPort.write(0x09);
   //long preambleSuresi = (long)sliderZamanlama.getValueI();
   //myPort.write((int)(preambleSuresi/256));                              //Preamble Suresi
   //myPort.write((int)(preambleSuresi-(int)(preambleSuresi/256)*256));    //Preamble Suresi
   //myPort.write(0x09);
   //long txDelaySuresi = (long)sliderTXDelay.getValueI();
   //myPort.write((int)(txDelaySuresi/256));                               //Kuyruk Suresi
   //myPort.write((int)(txDelaySuresi-(int)(txDelaySuresi/256)*256));      //Kuyruk Suresi
   //myPort.write(0x09);
   myPort.write(textfieldLatitude.getText());                            //Lat
   myPort.write(0x09);
   myPort.write(textfieldLongitude.getText());                           //Lon
   myPort.write(0x09);
   myPort.write(textfieldAltitude.getText());                            //Alt
   myPort.write(0x09);
   gondermeAktif = false;
   labelStatusMesaj.setText("Veriler gonderildi");
  //myPort.write('P');
} //_CODE_:buttonSend:872700:

public void textfieldCagriAdi_change1(GTextField source, GEvent event) { //_CODE_:textfieldCagriAdi:558481:
//  println("textfieldCagriAdi - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldCagriAdi:558481:

public void dropListSeriPort_click1(GDropList source, GEvent event) {
//  println("dropListSeriPort - GDropList >> GEvent." + event + " @ " + millis());
  labelStatusMesaj.setText("Seri port aciliyor");
  myPort = new Serial(this, source.getSelectedText(), 115200);
  delay(5000);
  myPort.write('!');
  labelStatusMesaj.setText("Seri port acildi");
}

public void dropListSSID_click1(GDropList source, GEvent event) { //_CODE_:dropListSSID:560365:
//  println("dropListSSID - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSSID:560365:

public void dropListSembol_click1(GDropList source, GEvent event) { //_CODE_:dropListSembol:606061:
//  println("dropListSembol - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSembol:606061:

//public void dropListGPSHizi_click1(GDropList source, GEvent event) { //_CODE_:dropListGPSHizi:549444:
//  println("dropListGPSHizi - GDropList >> GEvent." + event + " @ " + millis());
//} //_CODE_:dropListGPSHizi:549444:

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
  labelStatusMesaj.setText("Okuma Baslatildi");
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
  labelProgramAdi = labelFn(splashScreen, "iZCi hymTR APRS Tracker", 80, 85, 270, 30);
  labelProgramAdi.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  hazirlayanlar = labelFn(splashScreen, "HAZIRLAYANLAR", 160, 125, 120, 20);
  baris = labelFn(splashScreen,"Baris DINC\n  (TA7W)", 50, 150, 80, 30);
  burcu = labelFn(splashScreen, "Burcu AYBAK\n  (TA2NBA)", 170, 150, 90, 30);
  emre = labelFn(splashScreen, "Emre KELES\n (TA6AEU)", 290, 150, 80, 30);

  splashScreen.loop();
}

public void createMainGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GOLD_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("iZCi hymTR Ayar Programi (v01012020a)");
  String[] seriPortListesi = Serial.list();
  String[] ssidListesi = {"-0 Sabit Merkez","-7 El Telsizi ile hareketli","-9 Mobil arac"};
  String[] semboller = {"Ev","Motorsiklet","Araba"};
  String[] gpsHizlari = {"4800","9600","57600","115200"};
  gpsOptionGroup = new GToggleGroup();

  labelSeriPort = labelFn(this, "Seri Port", 20, 10, 80, 20);
  dropListSeriPort = dropListFn(seriPortListesi, "dropListSeriPort_click1", 76, 10, 374, 80, 3, 10);
  
  labelCagriAdi = labelFn(this, "Cagriadi", 20, 40, 80, 20);
  textfieldCagriAdi = textFieldFn("TA7W", "textfieldCagriAdi_change1", 76, 40, 150, 20, G4P.SCROLLBARS_NONE);
  labelSSID = labelFn(this, "SSID", 253, 40, 36, 20);
  dropListSSID = dropListFn(ssidListesi, "dropListSSID_click1", 290, 40, 160, 80, 3, 10);
  
  labelSembol = labelFn(this, "Sembol", 20, 70, 80, 20);
  dropListSembol = dropListFn(semboller, "dropListSembol_click1", 76, 70, 150, 80, 3, 10);
  
  labelGPS = labelFn(this, "GPS", 20, 100, 80, 20);
  radioButtonGPSVar = radioButtonFn("Var", "radioButtonGPSVar_clicked1", true, 76, 100, 50, 20); 
  radioButtonGPSYok = radioButtonFn("Yok", "radioButtonGPSYok_clicked1", false, 134, 100, 50, 20);
  //labelGPSPortHizi = labelFn(this, "GPS Port Hizi", 207, 100, 80, 20);
  //dropListGPSHizi = dropListFn(gpsHizlari, "dropListGPSHizi_click1", 290, 100, 160, 92, 4, 10);
  labelLatitude = labelFn(this, "Lat", 190, 100, 80, 20);// -9012.12,N Anitkabir Latitude
  textfieldLatitude = textFieldFn("3955.50N", "textfieldLatitude_change1", 210, 100, 66, 20, G4P.SCROLLBARS_NONE);
  labelLongitude = labelFn(this, "Lon", 280, 100, 80, 20);// -180,180 Anitkabir Longitude
  textfieldLongitude = textFieldFn("3250.22E", "textfieldLongitude_change1", 304, 100, 74, 20, G4P.SCROLLBARS_NONE);
  labelAltitude = labelFn(this, "Alt", 382, 100, 80, 20);
  textfieldAltitude = textFieldFn("2400", "textfieldAltitude_change1", 400, 100, 50, 20, G4P.SCROLLBARS_NONE);
  
  labelMesaj = labelFn(this, "Mesaj", 20, 130, 80, 20);
  textfieldMesaj = textFieldFn("QRV 145.500 Ceptel: 0 5XX XXX XX XX", "textfieldMesaj_change1", 76, 130, 374, 20, G4P.SCROLLBARS_NONE);
  
/*
  labelGonder = labelFn(this, "Gonder", 20, 160, 80, 20);
  checkboxLokasyon = checkboxFn("Lokasyon", "checkboxLokasyon_clicked1", true, 76, 160, 150, 20);
  checkboxYukseklik = checkboxFn("Yukseklik", "checkboxYukseklik_clicked1", false, 76, 180, 150, 20);
  checkboxBatarya = checkboxFn("Batarya Durumu", "checkboxBatarya_clicked1", false, 76, 200, 150, 20);
*/  
  labelAkilliBeacon = labelFn(this, "Akilli Beacon (Dakika)", 10, 220, 180, 20);
  sliderZamanlama = sliderFn(1, 1, 60, 60, "sliderZamanlama_change1", 10, 240, 440, 47, 10.0);
  
/*
  labelPreambleSuresi = labelFn(this, "Preamble Suresi (milisaniye)", 10, 300, 180, 20);
  sliderPreamble = sliderFn(350, 100, 1000, 20, "sliderPreamble_change1", 10, 320, 440, 50, 10.0);
  
  labelKuyrukSuresi = labelFn(this, "Kuyruk Suresi (milisaniye)", 10, 380, 190, 20);
  sliderTXDelay = sliderFn(100, 50, 500, 9, "sliderTXDelay_change1", 10, 400, 440, 50, 10.0);
*/  
  labelStatusMesaj = labelFn(this, "Program Baslatildi", 180, 430, 190, 20);
  
  buttonReceive = buttonFn("Bilgileri Cihazdan Al", "buttonReceive_click1", 10, 460, 210, 30);
  buttonSend = buttonFn("Bilgileri Cihaza Yukle", "buttonSend_click1", 229, 460, 220, 30);
  
  gpsOptionGroup.addControl(radioButtonGPSVar);
  gpsOptionGroup.addControl(radioButtonGPSYok);
  //labelGPSPortHizi.setVisible(true);
  //dropListGPSHizi.setVisible(true);
  labelStatusMesaj.setVisible(true);
  labelLatitude.setVisible(false);
  textfieldLatitude.setVisible(false);
  labelLongitude.setVisible(false);
  textfieldLongitude.setVisible(false);
  labelAltitude.setVisible(false);
  textfieldAltitude.setVisible(false);
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
//GLabel labelGPSPortHizi; 
GLabel labelLatitude;
GLabel labelLongitude;
GLabel labelAltitude;
GLabel labelMesaj; 
GLabel labelGonder; 
GLabel labelAkilliBeacon; 
GLabel labelPreambleSuresi; 
GLabel labelKuyrukSuresi;
GLabel labelStatusMesaj;
GOption radioButtonGPSVar;
GOption radioButtonGPSYok;
GTextField textfieldCagriAdi; 
GTextField textfieldMesaj;
GTextField textfieldLatitude;
GTextField textfieldLongitude;
GTextField textfieldAltitude;
GCheckbox checkboxLokasyon; 
GCheckbox checkboxYukseklik; 
GCheckbox checkboxBatarya; 
GDropList dropListSeriPort; 
GDropList dropListSSID; 
GDropList dropListSembol; 
//GDropList dropListGPSHizi; 
GSlider sliderZamanlama; 
GSlider sliderPreamble; 
GSlider sliderTXDelay; 
GButton buttonReceive; 
GButton buttonSend; 
GTimer timer1;
GToggleGroup gpsOptionGroup;
