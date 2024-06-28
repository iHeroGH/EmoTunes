import 'dart:convert';
import 'package:http/http.dart' as http;

class Response {

  final bool isSuccess;
  final String error;
  List<Map<String, dynamic>> songs;
  final String playlist;

  Response(
    {
      required this.isSuccess,
      required this.error,
      required this.songs,
      required this.playlist
    }
  );

  factory Response.fromRes(Map<String, dynamic> json){
    return Response(
      isSuccess: json['status'] as String == "success",
      error: json['error'] as String? ?? '',
      songs: parseSongs(json),
      playlist: json['playlist_url'] as String? ?? ''
    );
  }

  static List<Map<String, dynamic>> parseSongs(Map<String, dynamic> json){

    final songs = json['songs'] as List? ?? [];

    return songs.map((song) {
      final albumImage = song['album']['images'][0]['url'];
      final artistNames = (song['artists'] as List).map(
        (artist) => artist['name']
      ).join(', ');

      return {
        'song_name': song['name'],
        'song_id': song['id'],
        'artist': artistNames,
        'picture': albumImage
      };
    }).toList();
  }

  void printInfo(){
    print("Success: $isSuccess, Error: $error, Songs: $songs, URL: $playlist");
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

  static Future<Response> findSongs(
    String sentimentText
  ) async {

    var url = Uri.parse(
      "${apiUrl}recommend-songs"
    ).replace(queryParameters: {"entered_prompt": sentimentText});
    var response = await http.post(url);

    return Response.fromRes(jsonDecode(response.body));
  }

  static Future<Response> exportPlaylist(
    String songIds, String sentimentText
  ) async {
    var url = Uri.parse(
      "${apiUrl}export-playlist"
    ).replace(queryParameters: {
      "song_ids": songIds,
      "playlist_name": "EmoTunes Export",
      "playlist_description": sentimentText,
    });
    var response = await http.post(
      url,
      body: {
        'email_address': "sentisounds.cpp@gmail.com",
      }
    );

    return Response.fromRes(jsonDecode(response.body));
  }

}