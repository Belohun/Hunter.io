import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hunterio/domain_search_api_call.dart';
import 'package:provider/provider.dart';
import 'local_db.dart';
import 'main.dart';

//stripe.com

class domainSearch extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DomainSearchLayout(),
    );
  }
// #enddocregion build
}


class DomainSearchState extends State<DomainSearchLayout> {

  Future<List<Email>> futureEmails;


  @override
  Widget build(BuildContext context) {
    String _Email;
    String _ApiKey;


    setState(() {
      _Email = getEmail();
      _ApiKey = getApiKey();
      futureEmails = fetchEmails(
          "stripe.com" ,  _ApiKey);
    });
    return Scaffold(
      body: FutureBuilder<List<Email>>(
        future: futureEmails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final alreadySaved = true;
            final list = snapshot.data;
           return ListView.builder(
             padding: const EdgeInsets.all(16.0),
               itemBuilder: (context, i) {
                 var dh = DBHelper();
                 dh.init();
                 final ea = EmailAddress(value:snapshot.data[i].value);
                 List _saved=getTempSavedMails();
                 final alreadySaved = _saved.contains(snapshot.data[i].value);
                 return  Row(
                   children: <Widget>[
                 Expanded(
                     flex: 1,
                     child: domainRow(list[i])),
                     Center(
                       child: GestureDetector(
                         onTap: (){
                           setState(() {

                             if(alreadySaved){
                               dh.removeEmailAddress(ea.value);
                               removeFromTempSavedList(snapshot.data[i].value);
                               // _saved.removeWhere((item)=> item==snapshot.data.data.email);

                             }else{

                               //   _saved.add(snapshot.data.data.email);
                               dh.addEmailAddress(ea);
                               addToTempSavedList(snapshot.data[i].value);


                             }
                           });

                         },
                         child: Expanded(
                           flex: 3,
                           child: Center(
                             child: Icon(alreadySaved ? Icons.star : Icons.star_border,
                               color: alreadySaved ? Colors.yellow : null,),
                           ),
                         ),
                       ),
                     )
                   ],
                 );
               },itemCount: list.length,);

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




class DomainSearchLayout extends StatefulWidget {


  @override
  DomainSearchState createState() => DomainSearchState();
}
class domainRow extends StatelessWidget{

Email mail;
final _biggerFont = const TextStyle(fontSize: 18.0);
domainRow(this.mail);
  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(
        mail.firstName+" "+mail.lastName,
        style: _biggerFont,
      ),
      leading: CircleAvatar(child: Text(mail.firstName[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
      ,

      subtitle: Row(
        children: <Widget>[
          Text("Email: ",style: TextStyle(fontWeight: FontWeight.bold)),
          Text(mail.value),

        ],
      ),
      isThreeLine: true,
      onTap: () {
        Navigator.of(context).push(
        MaterialPageRoute<void>(
    builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getAppBarColor(),
        title: Text("Detalis"),
        /*backgroundColor: colorTheme().primaryColor*/
      ),
      body:  Center(
        child: ListView(/*children: divided*/
          children: <Widget>[

            Padding(
              padding:EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(child: Text(mail.firstName[0].toUpperCase(),style: TextStyle(color: Colors.white)),backgroundColor: Colors.blueGrey),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(mail.value!=null? mail.value : "Unknown", style: TextStyle(fontSize: 20),),
                    ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,child: Text("First Name: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2,child: Text(mail.firstName!=null? mail.firstName : "Unknown",style: _biggerFont,))

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,child: Text("Last Name: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2,child: Text(mail.lastName!=null? mail.lastName : "Unknown",style: _biggerFont,))

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,child: Text("Position: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2,child: Text(mail.position!=null? mail.position : "Unknown",style: _biggerFont,))

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,child: Text("Department: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2,child: Text(mail.department!=null? mail.department : "Unknown",style: _biggerFont,))

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1,child: Text("Confidence: ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2,child: Text(mail.confidence!=null? mail.confidence.toString() : "Unknown",style: _biggerFont,))

                  ],
                ),
              ),
            )
          ],),
      )
      ,
    );
            }
            )

        );


      },
    );
  }

}
