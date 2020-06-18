import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hunterio/RandomWords.dart';
import 'package:hunterio/circularButton.dart';
void main() {
  runApp(MyApp());
}
String appTitle = "Hunter.io";
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,mainButtonCliclTranslationAnimation;

  double getRadians (double degree){
    return degree/57.295779513;
  }
    @override
    void initState(){
    animationController= AnimationController(vsync:this,duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    mainButtonCliclTranslationAnimation= TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.0, end: 0.6),weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.6, end: 1.0),weight: 50)
    ]).animate(animationController);
    animationController.addListener(() {
      setState(() {

      });
    });
    super.initState();
    }

 /* int _counter = 0;
  var wordPair = WordPair.random();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _randomWord() {
    setState(() {
      wordPair= WordPair.random();
    });
  }*/
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child:RandomWords()

      ),
      floatingActionButton: Stack(
        children: <Widget>[

          Positioned(
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset.fromDirection(getRadians(270),degOneTranslationAnimation.value * 100),
                  child: Transform.scale(
                    scale: degOneTranslationAnimation.value,
                    child: circularButton(
                      width: 50,
                      height: 50,
                      icon: Icon(Icons.mail,color: Colors.white),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadians(225),degOneTranslationAnimation.value * 100),
                  child: Transform.scale(
                    scale: degOneTranslationAnimation.value,
                    child: circularButton(
                      width: 50,
                      height: 50,
                      icon: Icon(Icons.perm_identity,color: Colors.white),
                      color: Colors.green,
                    ),
                  ),
                ),
            Transform.translate(
              offset: Offset.fromDirection(getRadians(180),degOneTranslationAnimation.value * 100),

              child: Transform.scale(
                scale: degOneTranslationAnimation.value,
                    child: circularButton(
                      width: 50,
                      height: 50,
                      icon: Icon(Icons.business,color: Colors.white),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),


                   Transform.scale(
                     scale: mainButtonCliclTranslationAnimation.value,
                     child: circularButton(
                        width: 60,
                        height: 60,
                        icon: Icon(Icons.list,color: Colors.white),
                        color: Colors.red,
                      onClick: (){
                          if (animationController.isCompleted){
                            animationController.reverse();
                          }
                          else{
                            animationController.forward();
                          }
                      },
                      ),
                   ),



              ],
            ),
          )
        ],
      )
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
