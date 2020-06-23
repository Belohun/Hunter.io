import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hunterio/domain_search_api_call.dart';
import 'package:hunterio/email_finder_api_call.dart';
import 'package:hunterio/email_verification_api_call.dart';

import 'local_db.dart';
import 'main.dart';



class emailFinder extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailFinderLayout(),
    );
  }
// #enddocregion build
}

class EmailFinderState extends State<EmailFinderLayout> {

  Future<EmailFinder> futureEmailFinder;





  @override
  Widget build(BuildContext context) {
    final Set<EmailFinder> _saved = <EmailFinder>{};
    String _Email;
    String _ApiKey;
    setState(() {
      _Email = getEmail();
      _ApiKey = getApiKey();
    });
    futureEmailFinder = fetchFinder("Dustin","Moskovitz","asana.com",_ApiKey);

    return Scaffold(
      body: FutureBuilder<EmailFinder>(
        future: futureEmailFinder,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dh = DBHelper();
            dh.init();
            final ea = EmailAddress(value:snapshot.data.email);
            List _saved=getTempSavedMails();
            final alreadySaved = _saved.contains(snapshot.data.email);
            return ListTile(
              title: Text(snapshot.data.email,style: TextStyle(fontSize: 18.0)),
              leading: CircleAvatar(child: Text(snapshot.data.email[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
              , subtitle: Row(
              children: <Widget>[
                Text("Score: ",style: TextStyle(fontWeight: FontWeight.bold)),
                Text(snapshot.data.score.toString()),
                Text(" Positon: ",style: TextStyle(fontWeight: FontWeight.bold)),
                Text(snapshot.data.position)
              ],
            ),
              trailing: Icon(
                alreadySaved ? Icons.star : Icons.star_border,
                color: alreadySaved ? Colors.yellow : null,
              ),
              onTap: () {
                //Saving email
                setState(() {
                  if(alreadySaved){
                    dh.removeEmailAddress(ea.value);
                    removeFromTempSavedList(snapshot.data.email);
                  }else{
                    dh.addEmailAddress(ea);
                    addToTempSavedList(snapshot.data.email);


                  }
                });

              },


            );

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return   Center(
              child: CircularProgressIndicator()
          );
        },
      ),
    );
  }
}



// #enddocregion RWS-build

class EmailFinderLayout extends StatefulWidget {
  @override
  EmailFinderState createState() => EmailFinderState();
}
