import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class emailVerificationSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailVerificationSaved(),
    );
  }

}


class EmailVerificationSavedState extends State<EmailVerificationSaved> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    _suggestions.add(WordPair("First", "Word"));
    _suggestions.add(WordPair("Second", "Word"));
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          final index = i;
          return _buildRow(_suggestions[index]);
        },itemCount: _suggestions.length,);
  }
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(

      title: Text(
        pair.asPascalCase + "@email.com",
        style: _biggerFont,
      ),
      leading: CircleAvatar(child: Text(pair.first[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
      ,
      subtitle: Row(
        children: <Widget>[
          Text("Score:",style: TextStyle(fontWeight: FontWeight.bold)),
          Text(" 99"),
          Text(" Position:",style: TextStyle(fontWeight: FontWeight.bold)),
          Text(" 1")
        ],
      ),
      trailing: Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        color: alreadySaved ? Colors.yellow : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
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

class EmailVerificationSaved extends StatefulWidget {

  @override
  EmailVerificationSavedState createState() => EmailVerificationSavedState();
}
