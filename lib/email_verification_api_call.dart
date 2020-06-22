import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
Future<EmailVerification> fetchVerif(String email, String apiKey) async {
  String url = 'https://api.hunter.io/v2/email-verifier';
  try{
    final http.Response response =
    await http.get(
        url + '?email=' + email + '&api_key=' + apiKey
    );

    if (response.statusCode == 200) {
    // print(response.body);
      return EmailVerification.fromJson(json.decode(response.body));
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

class EmailVerificationData {
  final String result;
  final int score;
  final String email;

  EmailVerificationData(
      this.result, this.score, this.email
      );

  factory EmailVerificationData.fromJson(dynamic json) {
    return EmailVerificationData(
        json['result'] as String,
        json['score'] as int,
        json['email'] as String
    );
  }
}

class EmailVerification {
  final EmailVerificationData data;
  EmailVerification({this.data});
  factory EmailVerification.fromJson(Map<String, dynamic> json) {
    return EmailVerification(
      data: EmailVerificationData.fromJson(json['data']),
    );
  }
}