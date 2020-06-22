import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<List<Email>> fetchEmails(String domain, String apiKey) async {
  String url = 'https://api.hunter.io/v2/domain-search';
  try{
    final http.Response response =
    await http.get(
        url + '?domain=' + domain + '&api_key=' + apiKey
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return emailsToList(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Failed to load email, ${response.statusCode}');
      /*
      *
      * TODO: Implement Error response handling
      *
      */
    }
  }
  on SocketException catch(e) {
    print('Socket Exception. Check your network status. \n$e');
  }
  catch (e) {print('Unknown Exception: $e');}

}

class Email {
  final String value;
  final String type;
  final int confidence;
  final String firstName;
  final String lastName;
  final String position;
  final String department;

  Email(
      this.value, this.type, this.confidence,
      this.firstName, this.lastName,
      this.position, this.department
      );

  factory Email.fromJson(dynamic json) {
    return Email(
        json['value'] as String, json['type'] as String,
        json['confidence'] as int, json['first_name'] as String,
        json['last_name'] as String, json['position'] as String,
        json['department'] as String);
  }

  @override
  toString() {
    return(
        "${this.value}, ${this.type}, ${this.confidence}, " +
            "${this.firstName}, ${this.lastName}, ${this.position}, " +
            "${this.department}");
  }
}

emailsToList(String response) {
  var dataJson = jsonDecode(response)['data']['emails'];
  var emails = new List<Email>();
  for (var k in dataJson){emails.add(Email.fromJson(k));}

  return emails;
}