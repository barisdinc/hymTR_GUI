// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
//import peasy.*;
import processing.serial.*;

public void setup(){
  size(480, 500, JAVA2D);
  splashGUI();
  createMainGUI();
  
  timer1 = new GTimer(this, this, "timer1_Action1", 5000);
  timer1.start(1);
}

public void draw(){
  background(230,230,230);
}

public void timer1_Action1(GTimer source) { //_CODE_:timer1:910330:
  println("timer1 - GTimer >> an event occured @ " + millis());
  splashScreen.forceClose();
} //_CODE_:timer1:910330:


synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:seriportWindow:303233:
  appc.background(230);
} //_CODE_:seriportWindow:303233:

synchronized public void preSeriportWindow(PApplet appc, GWinData data) { //_CODE_:seriportWindow:982297:
  println("seriportWindow - pre method called " + millis());
} //_CODE_:seriportWindow:982297:

synchronized public void postSeriportWindow(PApplet appc, GWinData data) { //_CODE_:seriportWindow:981943:
  println("seriportWindow - post method called " + millis());
} //_CODE_:seriportWindow:981943:

public void oncloseSeriportWindow(GWindow window) { //_CODE_:seriportWindow:346375:
  println("seriportWindow - window closed at " + millis());
} //_CODE_:seriportWindow:346375:

public void buttonBaglanClick(GButton source, GEvent event) { //_CODE_:buttonBaglan:635785:
  println("buttonBaglan - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonBaglan:635785:

public void imgButton3_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsat:765992:
  println("imgButton3 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsat:765992:

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:splashScreen:721218:
  appc.background(230);
} //_CODE_:splashScreen:721218:

public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsatLogo:646942:
  println("imgButton1 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsatLogo:646942:

public void imgButton2_click1(GImageButton source, GEvent event) { //_CODE_:imgButtonTamsatInfo:450767:
  println("imgButton2 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButtonTamsatInfo:450767:

public void checkboxLokasyon_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxLokasyon:939952:
  println("checkboxLokasyon - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxLokasyon:939952:

public void checkboxYukseklik_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxYukseklik:919125:
  println("checkbox2 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxYukseklik:919125:

public void sliderZamanlama_change1(GSlider source, GEvent event) { //_CODE_:sliderZamanlama:300012:
  println("sliderZamanlama - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderZamanlama:300012:

public void checkboxBatarya_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkboxBatarya:493573:
  println("checkboxBatarya - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxBatarya:493573:

public void buttonSend_click1(GButton source, GEvent event) { //_CODE_:buttonSend:872700:
  println("buttonSend - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonSend:872700:

public void textfieldCagriAdi_change1(GTextField source, GEvent event) { //_CODE_:textfieldCagriAdi:558481:
  println("textfieldCagriAdi - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldCagriAdi:558481:

public void dropListSSID_click1(GDropList source, GEvent event) { //_CODE_:dropListSSID:560365:
  println("dropListSSID - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSSID:560365:

public void dropListSembol_click1(GDropList source, GEvent event) { //_CODE_:dropListSembol:606061:
  println("dropListSembol - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListSembol:606061:

public void dropListGPSHizi_click1(GDropList source, GEvent event) { //_CODE_:dropListGPSHizi:549444:
  println("dropListGPSHizi - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListGPSHizi:549444:

public void textfieldMesaj_change1(GTextField source, GEvent event) { //_CODE_:textfieldMesaj:236196:
  println("textfieldMesaj - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldMesaj:236196:

public void sliderPreamble_change1(GSlider source, GEvent event) { //_CODE_:sliderPreamble:934008:
  println("sliderPreamble - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderPreamble:934008:

public void sliderTXDelay_change1(GSlider source, GEvent event) { //_CODE_:sliderTXDelay:750989:
  println("sliderTXDelay - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sliderTXDelay:750989:

public void buttonReceive_click1(GButton source, GEvent event) { //_CODE_:buttonReceive:300015:
  println("buttonReceive - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonReceive:300015:



public void splashGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GOLD_SCHEME);
  G4P.setMouseOverEnabled(false);
  splashScreen = GWindow.getWindow(this, "hymTR APRS Tracker", 0, 0, 420, 200, JAVA2D);
  splashScreen.noLoop();
  splashScreen.setActionOnClose(G4P.CLOSE_WINDOW);
  splashScreen.addDrawHandler(this, "win_draw1");
  imgButtonTamsatLogo = new GImageButton(splashScreen, 15, 15, 70, 70, new String[] { "TAMSATLOGOBUYUK.jpg", "TAMSATLOGOBUYUK.jpg", "TAMSATLOGOBUYUK.jpg" } );
  imgButtonTamsatLogo.addEventHandler(this, "imgButton1_click1");
  imgButtonTamsatInfo = new GImageButton(splashScreen, 80, 12, 340, 80, new String[] { "tamsatbuyuklogoen.jpg", "tamsatbuyuklogoen.jpg", "tamsatbuyuklogoen.jpg" } );
  imgButtonTamsatInfo.addEventHandler(this, "imgButton2_click1");
  labelProgramAdi = new GLabel(splashScreen, 80, 101, 270, 30);
  labelProgramAdi.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelProgramAdi.setText("hymTR APRS Tracker");
  labelProgramAdi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelProgramAdi.setOpaque(true);
  baris = new GLabel(splashScreen, 50, 170, 80, 20);
  baris.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  baris.setText("Baris DINC");
  baris.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  baris.setOpaque(false);
  burcu = new GLabel(splashScreen, 170, 170, 80, 20);
  burcu.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  burcu.setText("Burcu AYBAK");
  burcu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  burcu.setOpaque(false);
  hazirlayanlar = new GLabel(splashScreen, 150, 140, 120, 20);
  hazirlayanlar.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  hazirlayanlar.setText("HAZIRLAYANLAR");
  hazirlayanlar.setLocalColorScheme(GCScheme.RED_SCHEME);
  hazirlayanlar.setOpaque(false);
  emre = new GLabel(splashScreen, 290, 170, 80, 20);
  emre.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  emre.setText("Emre KELES");
  emre.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  emre.setOpaque(false);
  splashScreen.loop();
}


public void createMainGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.GOLD_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("hymTR Ayar Programi");

  labelSeriPort = new GLabel(this, 20, 10, 80, 20);
  labelSeriPort.setText("Seri Port");
  labelSeriPort.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelSeriPort.setOpaque(false);

  dropListSeriPort = new GDropList(this, 99, 10, 290, 80, 3, 10);
//  dropListSSID.setItems(loadStrings("list_560365"), 3);
  String[] seriportListesi = Serial.list();
  dropListSeriPort.setItems(seriportListesi, 3);
  dropListSeriPort.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  dropListSeriPort.addEventHandler(this, "dropListSeriPort_click1");  

  labelCagriAdi = new GLabel(this, 20, 40, 80, 20);
  labelCagriAdi.setText("Cagriadi");
  labelCagriAdi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelCagriAdi.setOpaque(false);

  textfieldCagriAdi = new GTextField(this, 99, 40, 150, 20, G4P.SCROLLBARS_NONE);
  textfieldCagriAdi.setText("TA7W");
  textfieldCagriAdi.setPromptText("Buraya Cagri Adinizi Giriniz (SSID haric)");
  textfieldCagriAdi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  textfieldCagriAdi.setOpaque(true);
  textfieldCagriAdi.addEventHandler(this, "textfieldCagriAdi_change1");

  labelSSID = new GLabel(this, 253, 40, 36, 20);
  labelSSID.setText("SSID");
  labelSSID.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelSSID.setOpaque(false);
  dropListSSID = new GDropList(this, 290, 40, 160, 80, 3, 10);
//  dropListSSID.setItems(loadStrings("list_560365"), 3);
  String[] ssidListesi = {"-0 Sabit Merkez","-7 El Telsizi ile hareketli","-9 Mobil arac"};
  dropListSSID.setItems(ssidListesi, 3);
  dropListSSID.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  dropListSSID.addEventHandler(this, "dropListSSID_click1");  

  labelSembol = new GLabel(this, 20, 70, 80, 20);
  labelSembol.setText("Sembol");
  labelSembol.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelSembol.setOpaque(false);
  dropListSembol = new GDropList(this, 100, 70, 150, 80, 3, 10);
//  dropListSembol.setItems(loadStrings("list_606061"), 3);
  String[] semboller = {"Ev","El Telsizi","Motorsiklet","Araba"};
  dropListSembol.setItems(semboller, 3);
  dropListSembol.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  dropListSembol.addEventHandler(this, "dropListSembol_click1");

  labelGPSPortHizi = new GLabel(this, 20, 100, 80, 20);
  labelGPSPortHizi.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  labelGPSPortHizi.setText("GPS Port Hizi");
  labelGPSPortHizi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelGPSPortHizi.setOpaque(false);
  dropListGPSHizi = new GDropList(this, 100, 100, 150, 80, 3, 10);
//  dropListGPSHizi.setItems(loadStrings("list_549444"), 1);
  String[] gpsHizlari = {"4800","9600","57600","115200"};
  dropListGPSHizi.setItems(gpsHizlari, 1);
  dropListGPSHizi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  dropListGPSHizi.addEventHandler(this, "dropListGPSHizi_click1");

  labelMesaj = new GLabel(this, 20, 130, 80, 20);
  labelMesaj.setText("Mesaj");
  labelMesaj.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelMesaj.setOpaque(false);
  textfieldMesaj = new GTextField(this, 100, 130, 350, 20, G4P.SCROLLBARS_NONE);
  textfieldMesaj.setText("QRV 145.500 Ceptel: 0 5XX XXX XX XX");
  textfieldMesaj.setPromptText("Buraya havaya yayimlanacak mesajinizi yaziniz");
  textfieldMesaj.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  textfieldMesaj.setOpaque(true);
  textfieldMesaj.addEventHandler(this, "textfieldMesaj_change1");

  labelGonder = new GLabel(this, 20, 160, 80, 20);
  labelGonder.setText("Gonder");
  labelGonder.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelGonder.setOpaque(false);
  checkboxLokasyon = new GCheckbox(this, 100, 160, 150, 20);
  checkboxLokasyon.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxLokasyon.setText("Lokasyon");
  checkboxLokasyon.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  checkboxLokasyon.setOpaque(true);
  checkboxLokasyon.addEventHandler(this, "checkboxLokasyon_clicked1");
  checkboxLokasyon.setSelected(true);
  checkboxYukseklik = new GCheckbox(this, 100, 180, 150, 20);
  checkboxYukseklik.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxYukseklik.setText("Yukseklik");
  checkboxYukseklik.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  checkboxYukseklik.setOpaque(true);
  checkboxYukseklik.addEventHandler(this, "checkboxYukseklik_clicked1");
  checkboxBatarya = new GCheckbox(this, 100, 200, 150, 20);
  checkboxBatarya.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxBatarya.setText("Batarya Durumu");
  checkboxBatarya.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  checkboxBatarya.setOpaque(true);
  checkboxBatarya.addEventHandler(this, "checkboxBatarya_clicked1");

  labelAkilliBeacon = new GLabel(this, 10, 220, 180, 20);
  labelAkilliBeacon.setText("Akilli Beacon (Dakika)");
  labelAkilliBeacon.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelAkilliBeacon.setOpaque(false);
  sliderZamanlama = new GSlider(this, 10, 240, 440, 47, 10.0);
  sliderZamanlama.setShowValue(true);
  sliderZamanlama.setShowLimits(true);
  sliderZamanlama.setLimits(1, 1, 60);
  sliderZamanlama.setNbrTicks(10);
  sliderZamanlama.setStickToTicks(true);
  sliderZamanlama.setShowTicks(true);
  sliderZamanlama.setNumberFormat(G4P.INTEGER, 0);
  sliderZamanlama.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  sliderZamanlama.setOpaque(true);
  sliderZamanlama.addEventHandler(this, "sliderZamanlama_change1");

  labelPreambleSuresi = new GLabel(this, 10, 300, 180, 20);
  labelPreambleSuresi.setText("Preamble Suresi (milisaniye)");
  labelPreambleSuresi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelPreambleSuresi.setOpaque(false);
  sliderPreamble = new GSlider(this, 10, 320, 440, 50, 10.0);
  sliderPreamble.setShowValue(true);
  sliderPreamble.setShowLimits(true);
  sliderPreamble.setLimits(350, 100, 1000);
  sliderPreamble.setNbrTicks(20);
  sliderPreamble.setStickToTicks(true);
  sliderPreamble.setShowTicks(true);
  sliderPreamble.setNumberFormat(G4P.INTEGER, 0);
  sliderPreamble.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  sliderPreamble.setOpaque(true);
  sliderPreamble.addEventHandler(this, "sliderPreamble_change1");


  labelKuyrukSuresi = new GLabel(this, 10, 380, 190, 20);
  labelKuyrukSuresi.setText("Kuyruk Suresi (milisaniye)");
  labelKuyrukSuresi.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  labelKuyrukSuresi.setOpaque(false);
  sliderTXDelay = new GSlider(this, 10, 400, 440, 50, 10.0);
  sliderTXDelay.setShowValue(true);
  sliderTXDelay.setShowLimits(true);
  sliderTXDelay.setLimits(100, 50, 500);
  sliderTXDelay.setNbrTicks(9);
  sliderTXDelay.setStickToTicks(true);
  sliderTXDelay.setShowTicks(true);
  sliderTXDelay.setNumberFormat(G4P.INTEGER, 0);
  sliderTXDelay.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  sliderTXDelay.setOpaque(true);
  sliderTXDelay.addEventHandler(this, "sliderTXDelay_change1");

  buttonReceive = new GButton(this, 10, 460, 210, 30);
  buttonReceive.setText("Bilgileri Cihazdan Al");
  buttonReceive.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  buttonReceive.addEventHandler(this, "buttonReceive_click1");

  buttonSend = new GButton(this, 229, 460, 220, 30);
  buttonSend.setText("Bilgileri Cihaza Yukle");
  buttonSend.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  buttonSend.addEventHandler(this, "buttonSend_click1");


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
GLabel labelGPSPortHizi; 
GLabel labelMesaj; 
GLabel labelGonder; 
GLabel labelAkilliBeacon; 
GLabel labelPreambleSuresi; 
GLabel labelKuyrukSuresi; 

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
