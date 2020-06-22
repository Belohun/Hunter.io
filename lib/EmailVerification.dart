import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hunterio/domain_search_api_call.dart';
import 'package:hunterio/email_verification_api_call.dart';

import 'main.dart';
final Set<EmailVerificationData> _saved = <EmailVerificationData>{};


class emailVerification extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailVerificationLayout(),
    );
  }
// #enddocregion build
}

class EmailVerificationState extends State<EmailVerificationLayout> {

  Future<EmailVerification> futureEmailVerification;
  Future<List<Email>> futureEmails;

  @override
  void initState() {
    super.initState();
    futureEmailVerification = fetchVerif(
       getEmail(),  getApiKey());
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 180,
              width: double.maxFinite,
              child: FutureBuilder<EmailVerification>(
                future: futureEmailVerification,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    bool alreadySaved = _saved.contains(snapshot.data.data);
                    return ListTile(
                      title: Text(snapshot.data.data.email,style: TextStyle(fontSize: 18.0)),
                        leading: CircleAvatar(child: Text(snapshot.data.data.email[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
                      , subtitle: Row(
                      children: <Widget>[
                        Text("Score: ",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(snapshot.data.data.score.toString()),
                        Text(" Result: ",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(snapshot.data.data.result)
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
                            _saved.remove(snapshot.data.data);
                          }else{
                            _saved.add(snapshot.data.data);


                          }
                        });

                      },


                    );

                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return   Center(
                        child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: const CircularProgressIndicator()
                      )
                  );
                },
              ),
            ),
           /* FutureBuilder<List<Email>>(
                future: futureEmails,
                builder: (context, snapshot) {
                    return Text(futureEmails.toString());

                }
            ),*/
          ],

        ),
    );
  }
}



// #enddocregion RWS-build


class emailVeriBody extends StatelessWidget {
  EmailVerificationData valueV;
  emailVeriBody(this.valueV);

  bool alreadySaved =true;

  @override
  Widget build(BuildContext context) {
    if(valueV.email!=null){
      print(valueV.email);
      return ListTile(
        title: Text(
          valueV.email,
          style: TextStyle(fontSize: 18.0),
        ),
        leading: CircleAvatar(child: Text(valueV.email[0].toUpperCase(),style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueGrey,)
        ,
        subtitle: Row(
          children: <Widget>[
            Text("Score: ",style: TextStyle(fontWeight: FontWeight.bold)),
            Text(valueV.score.toString()),
            Text(" Result: ",style: TextStyle(fontWeight: FontWeight.bold)),
            Text(valueV.result)
          ],
        ),
        trailing: Icon(
          alreadySaved ? Icons.star : Icons.star_border,
          color: alreadySaved ? Colors.yellow : null,
        ),
        onTap: () {

        },
      );
    }else {
      if(valueV==null){
        return Center(child: Text("Error while fetching data"));
      }
    }
    return Center(child: CircularProgressIndicator());

  }


}

class EmailVerificationLayout extends StatefulWidget {


  @override
  EmailVerificationState createState() => EmailVerificationState();
}