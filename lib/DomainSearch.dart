import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hunterio/domain_search_api_call.dart';
import 'package:provider/provider.dart';
import 'main.dart';

//stripe.com
final Set<Email> _savedMails = <Email>{};
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
            final list = snapshot.data;
           return ListView.builder(
             padding: const EdgeInsets.all(16.0),
               itemBuilder: (context, i) {
                 return Dismissible(
                     key: Key(list[i].value),
                     background: Container(
                       height: 30,
                       alignment: AlignmentDirectional.centerStart,
                       padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                       color: Colors.redAccent,
                       child: Icon(Icons.delete),
                     ),
                     direction: DismissDirection.startToEnd,
                     dismissThresholds:{
                       DismissDirection.startToEnd: 0.5
                 },
                     onDismissed: (direction) {
                     /*  setState(() {
                         list.removeAt(i);
                       });*/

                       Scaffold.of(context).showSnackBar(
                         SnackBar(
                           content: Text("Item removed"),
                         ),
                       );
                     },


                     child: domainRow(list[i]));
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
    final alreadySaved = _savedMails.contains(mail);
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
      trailing:Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        color: alreadySaved ? Colors.yellow : null,
      ),
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
