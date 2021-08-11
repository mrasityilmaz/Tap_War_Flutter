import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:math' as math;

void main() {
  runApp(Phoenix(child: TapWar()));
}

class TapWar extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TabWar',
     
      home: Main(),
    );
  }
}


double mainContainerH = 250; //Merkezdeki containerin ilk yüksekliği
double mainContainerW = 250;//Merkezdeki containerin ilk genişliği

var mainContainerGradient = LinearGradient(   //Merkezdeki containerin ilk rengi
  colors: [Colors.black, Colors.red, Colors.green, Colors.orange],
  end: Alignment.topLeft,
  begin: Alignment.bottomRight,
);

// Oyuncu skorları
double oyuncu1Skor = 0;
double oyuncu2Skor = 0;
 

 // Oyuncuların seçebileceği renkler kendi bölgelerine tıkladıkça değişir 
 // İstediğiniz renkleri bu listeye ekleyebilirsiniz
List<dynamic> colors = [

 
 Colors.pink,
 Colors.lime,
  Colors.brown,
  Colors.cyan,
  Colors.deepPurple,
  Colors.yellow,

  Colors.red
];
var kazananTaraf ;
//***

// oyuncuların başlangıçtaki container renkleri
var oyuncu2Color = Colors.cyan.shade600;
var oyuncu1Color = Colors.amber;

int tabControlValue = 1; // Giriş sayfası =1 / Oyun sayfası = 0






class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
      body: tabControlValue == 1 // Oyun / Giriş sayfasına göre body değişiyor 1= giriş 0= oyun
          ? Stack(

              children: [
                Column(
                  
                  children: [
                        
                    //**************** */ OYUNCU 2 GİRİŞ SAYFASI 
                    InkWell(
                      focusColor: Colors.white,
                      splashColor: Colors.white,
                      onTap: () {
                        setState(() {
                         var color = colors[(math.Random().nextInt(colors.length))];
                          oyuncu2Color = color != oyuncu1Color ? color : colors[(math.Random().nextInt(colors.length))] ;
                        });
                      },
                      child: Container(
                        color: oyuncu2Color,
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        height: MediaQuery.of(context).size.height / 2,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: RotatedBox( // Oyuncu 2 ters yerleşim için rotated box
                            quarterTurns: 2,
                            child: ListTile(
                                title: Text("Oyuncu 2",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                subtitle: Text("Rengini değiştirmek için alana tıkla",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                              ),
                          ),
                        ),
                      ),
                    ),
                    //**************** */ OYUNCU 2 GİRİŞ SAYFASI 
                        
                        
                        
                    // ***************** OYUNCU 1 GİRİŞ SAYFASI 
                    InkWell(
                      focusColor: Colors.white,
                      splashColor: Colors.white,
                      onTap: () {
                        setState(() {
                          var color = colors[(math.Random().nextInt(colors.length))];
                          oyuncu1Color = color != oyuncu2Color ? color : colors[(math.Random().nextInt(colors.length))] ;
                        });
                      },
                      child: Container(
                        color: oyuncu1Color,
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        height: MediaQuery.of(context).size.height / 2,
                        
                        child:  Align(
                          alignment: Alignment.bottomRight,
                          child: ListTile(
                            title: Text("Oyuncu 1",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            subtitle: Text("Rengini değiştirmek için alana tıkla",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                          ),
                        )
                      ),
                    ),
                     // ***************** OYUNCU 1 GİRİŞ SAYFASI 
                  ],
                ),
                Center( // Giriş sayfasının merkezinde bulunan Container 
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
          
          
                    onTap: () {},
          
                     // Container üzerine gelince value true değer dönderir
                     // true ise Container belirtilen genişliğe kadar genişler ve renk düzeni tersine çevrilir
                     // end>begin  begin > end olarak tersine çevrilir
                    onHover: (value) {
                      setState(() {
                        if (value) {
                          mainContainerH = 280;
                          mainContainerW = 280;
                          mainContainerGradient = LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.red,
                              Colors.blueAccent,
                              Colors.green,
                              Colors.orange
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          );
                        } 
                        
                        // value false ise Container tekrar eski haline döndürülür
                        else {
                          mainContainerGradient = LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.red,
                              Colors.green,
                              Colors.orange
                            ],
                            end: Alignment.topLeft,
                            begin: Alignment.bottomRight,
                          );
                          mainContainerH = 250;
                          mainContainerW = 250;
                        }
                      });
                    },
          
                    child: AnimatedContainer( /// Animated Container ***************
                      alignment: FractionalOffset.center,
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                          gradient: mainContainerGradient,//değişen renkler
                          color: Colors.grey.shade700,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset.fromDirection(20, 15))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      height: mainContainerH, 
                      width: mainContainerW,
                      child: 
                      Column(
          
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
          
                          // TAPWAR CONTAİNER ***************
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset.fromDirection(1))
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Text(
                                "👇TapWar",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .8,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset.fromDirection(30)),
                                      Shadow(
                                          color: Colors.red,
                                          offset: Offset.fromDirection(10))
                                    ]),
                              )),
                          // TAPWAR CONTAİNER ***************
          
                          Spacer(
                            flex: 2,
                          ),
          
          
          
                          // Sadece kazananTaraf değişkeni dolu olduğunda çalışır ve Centerdaki Container'a kazanan oyuncuyu yazar 
                          if(kazananTaraf != null) Text("Kazanan Oyuncu:"+kazananTaraf.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                          
                          
                          Spacer(
                            flex: 2,
                          ),
          
          
                          // BAŞLAT BUTONU**************
                          CupertinoButton(
                              padding: EdgeInsets.all(10),
                              color: Colors.white38,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Text(
                                "Başlat",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.7),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .8,
                                ),
                              ),
                              onPressed: () {
                                //Butona basıldığında skorlar sıfırlanır 
                                //ve tabcontrolvalue 0 değeri atanır 
                                //böylece tekrardan giriş sayfası aktif olur
                                //Phoniz flutter_phonix kullanılmıştır widget restartı için kullanılır
                                Phoenix.rebirth(context); // Restart
                                  //Skorlar sıfırlanıyor
                                oyuncu1Skor = 0;
                                oyuncu2Skor = 0;
                                tabControlValue = 0;
                              }),
                          // BAŞLAT BUTONU*********************
          
          
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(   // ************** OYUN SAYFASI ****************   
              children: [

                // OYUNCU 2 CONTAİNER
                Container(
                  color: oyuncu2Color,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),//Containerın maxheight değeri ekran yüksekliği ile sınırlandırılır
                      height: MediaQuery.of(context).size.height / 2 + oyuncu2Skor, // Container yüksekliği ekranın yarısı + oyuncunun skoru olarak güncellenir her seferinde
                  child: InkWell(
                    focusColor: Colors.white,
                    splashColor: Colors.white,
                    onTap: () {
                      setState(() {
                        if (MediaQuery.of(context).size.height >=        
                            MediaQuery.of(context).size.height / 2 + oyuncu2Skor) {   // Containerin yüksekliği ekranın yarısı + oyuncu skorundan büyük olduğu sürece skor artar
                          oyuncu2Skor = (oyuncu2Skor + 20);//oyuncu 2 skoru 20 artar 
                          oyuncu1Skor = oyuncu1Skor - 20;// ve oyuncu 1 skoru 20 azaltılır
                        }

                        if (MediaQuery.of(context).size.height <=
                            MediaQuery.of(context).size.height / 2 + oyuncu2Skor) { // Eğer Container yüksekliği max seviye eşit olur veya aşarsa oyun biter
                         
                          kazananTaraf = 2; // Kazanantaraf değişkenine göre ekrana kazananın yazılması için oyuncu numarası atanır
                          tabControlValue = 1; // Giriş sayfası için tekrar 1 atanır
                        }
                      });
                    },
                   
                  ),
                ), 
                // OYUNCU 2 CONTAİNER




                // OYUNCU 1 CONTAİNER
                Container(
                  color: oyuncu1Color,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),//Containerın maxheight değeri ekran yüksekliği ile sınırlandırılır
                  height: MediaQuery.of(context).size.height / 2 + oyuncu1Skor, // Container yüksekliği ekranın yarısı + oyuncunun skoru olarak güncellenir her seferinde
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (MediaQuery.of(context).size.height >=
                            MediaQuery.of(context).size.height / 2 + oyuncu1Skor) { // Containerin yüksekliği ekranın yarısı + oyuncu skorundan büyük olduğu sürece skor artar
                          oyuncu1Skor = (oyuncu1Skor + 20);//oyuncu 1 skoru 20 artar
                          oyuncu2Skor = oyuncu2Skor - 20;//oyuncu 2 skoru 20 azaltılır
                        }

                        if (MediaQuery.of(context).size.height <=
                            MediaQuery.of(context).size.height / 2 + oyuncu1Skor) {// Eğer Container yüksekliği max seviye eşit olur veya aşarsa oyun biter
                          kazananTaraf = 1;// Kazanantaraf değişkenine göre ekrana kazananın yazılması için oyuncu numarası atanır
                          tabControlValue = 1; // Giriş sayfasının açılması için 1 atanır
                        }
                      });
                    },
                  ),
                ),
                // OYUNCU 1 CONTAİNER
              ],
            ),
             // ************** OYUN SAYFASI **************** 
    ));
  }
}

// Widgeta benzersiz bir key atar ve yeniden başlatır 
// child zorunludur 
// runApp içinde Main widget bu yüzden Phonex widgetine sarılmıştır 
class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
