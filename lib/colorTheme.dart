import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hunterio/RandomWords.dart';
import 'package:hunterio/circularButton.dart';
class colorTheme{
  Color primaryColor = Colors.deepOrange;
  Color primaryColorAccent = Colors.orangeAccent;
  Color mailColor = Colors.blue;
  Color domainColor = Colors.green;
  Color verifieduserColor = Colors.orangeAccent;


}
class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
/*class ThemeBuilder extends StatefulWidget{
 final Widget Function(BuildContext context, Brightness brightness) builder;
 ThemeBuilder({this.builder})

 @override _ThemeBuilderState createState() => _ThemeBuilderState();


}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness _brightness;
  @override void initState(){
    super.initState();
        _brightness = Brightness.light;
  }
  @override
  Widget build(BuildContext context) {
 return widget.builder(
   context, _brightness;

 );
  }
  void changeTheme(){

    setState(() {
      _brightness = _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    });

  }
}*/

