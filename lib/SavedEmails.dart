import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'local_db.dart';
import 'main.dart';
class emailSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailSaved(),
    );
  }

}


class EmailSavedState extends State<EmailSaved> {
  List _saved=getTempSavedMails();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions() {
    return ListView.builder(

        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          var dh = DBHelper();
          dh.init();

          return Dismissible(
            key: new GlobalKey<ScaffoldState>(),
            direction: DismissDirection.endToStart,
              child: _buildRow(_saved[i])
          ,onDismissed:(direction){
             removeFromTempSavedList(_saved[i]);
             dh.removeEmailAddress(_saved[i]);
          } ,
            background:Container(
              child: Icon(Icons.delete_forever),
            ),
          );
        },itemCount: _saved.length,);
  }
  Widget _buildRow(String mail) {

    return ListTile(
      title: Text(
        mail,
        style: _biggerFont,
      ),
      leading: CircleAvatar(child: Text(mail[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
      ,
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _buildSuggestions(),
    );
  }

// #enddocregion RWS-build
// #docregion RWS-var
}
// #enddocregion RWS-var

class EmailSaved extends StatefulWidget {

  @override
  EmailSavedState createState() => EmailSavedState();
}
