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
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final _biggerFont = const TextStyle(fontSize: 18.0);
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
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          /*final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();*/

          return Scaffold(
            appBar: AppBar(
              title: Text('Options'),
            ),
            body:  Center(
              child: ListView(/*children: divided*/
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Night mode", style: _biggerFont,),
                          Switch(
                            value: false,
                            onChanged: (bool state){

                              print(state);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(

                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Your api key:", style: _biggerFont,),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(

                                hintText: 'Enter your Api key'
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],),
            )
            ,
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text('Hunter.io'),
          actions: <Widget>[      // Add 3 lines from here...
            IconButton(icon: Icon(Icons.settings), onPressed: _pushSaved),

          ],                      // ... to here.
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  decoration:BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[Colors.orangeAccent,Colors.deepOrange])
                  )
                  ,child: Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      child: Material(

                          elevation: 10,
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),

                        child: Padding(

                          padding: EdgeInsets.all(17.0),
                          child: Image.asset("images/hunterio.png",height: 100,width: 100,),
                        ),
                         ),
                    ),
                  )),
              customListTile(Icons.mail_outline,"Mails",Colors.blue),
              customListTile(Icons.perm_identity,"Domains",Colors.green),
              customListTile(Icons.verified_user,"Verified mails",Colors.orangeAccent)
            ],
          ),
        ),

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
                      icon: Icon(Icons.verified_user,color: Colors.white),
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
                        color: Colors.deepPurple,
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
class customListTile extends StatelessWidget{
  String text;
  final iconColor;
  final icon;

  customListTile(this.icon,this.text,this.iconColor);
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom:20.0 ),

      child: Padding(
        padding:  EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: (){},
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Icon(icon, color: iconColor,size: 30,),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(text, style: TextStyle(fontSize: 20.0 ),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
