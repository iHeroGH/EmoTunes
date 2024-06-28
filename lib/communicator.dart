import 'dart:convert';
import 'package:http/http.dart' as http;

class Response {

  final bool isSuccess;
  final String error;
  final String body;

  Response({required this.isSuccess, required this.error, required this.body});

  factory Response.fromRes(Map<String, dynamic> json){
    return Response(
      isSuccess: json['status'] as String == "success",
      error: json['error'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  void printInfo(){
    print("Success: $isSuccess, Error: $error, Body: $body");
  }

}

class Communicator{

  static const String apiUrl = "http://192.168.0.141:5000/";

  static Future<Response> performSignUp(
    String emailAddress,
    String password,
    String firstName,
    String lastInitial
  ) async {

    var url = Uri.parse("${apiUrl}sign-up");
    var response = await http.post(
      url,
      body: {
        'email_address': emailAddress,
        'password': password,
        'first_name': firstName,
        'lastInitial': lastInitial
      }
    );

    return Response.fromRes(jsonDecode(response.body));
  }

  static Future<Response> performAuthenticate(
    String emailAddress,
    String enteredAuthCode
  ) async {

    var url = Uri.parse("${apiUrl}authenticate");
    var response = await http.post(
      url,
      body: {
        'email_address': emailAddress,
        'entered_auth_code': enteredAuthCode,
      }
    );

    return Response.fromRes(jsonDecode(response.body));
  }

  static Future<Response> performLogin(
    String emailAddress,
    String password
  ) async {

    var url = Uri.parse("${apiUrl}login");
    var response = await http.post(
      url,
      body: {
        'email_address': emailAddress,
        'password': password,
      }
    );

    return Response.fromRes(jsonDecode(response.body));
  }

}