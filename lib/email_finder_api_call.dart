import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<EmailFinder> fetchFinder(String firstName, String lastName, String domain, String apiKey) async {
  String url = 'https://api.hunter.io/v2/email-finder';
  try{
    final http.Response response =
    await http.get(
        url + '?first_name=' + firstName + '&last_name=' + lastName + '&domain=' + domain + '&api_key=' + apiKey
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return email(response.body);
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


class EmailFinder {
  final String email;
  final int score;
  final String position;

  EmailFinder(
      this.email, this.score, this.position
      );

  factory EmailFinder.fromJson(dynamic json) {
    return EmailFinder(
        json['email'] as String,
        json['score'] as int,
        json['position'] as String
    );
  }

  @override
  toString() {
    return("${this.email}, ${this.score}, ${this.position}");
  }
}

email(String response) {
  var dataJson = jsonDecode(response)['data'];
  return EmailFinder.fromJson(dataJson);
}