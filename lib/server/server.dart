import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


const url = "192.168.1.6";
GoogleSignIn googleSignIn = GoogleSignIn();

Future uploadData() async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.https(url, '5001/users'),
        body: {'name': 'doodle', 'color': 'blue'});
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var uri = Uri.parse(decodedResponse['uri'] as String);
    print(await client.get(uri));
  } finally {
    client.close();
  }
  // var uri = Uri.parse(url);
  // var response = await http.post(uri, body: {
  //   "name": tempGoogleIDName.toString(),
  //   "email": tempGoogleIDEmail.toString(),
  // });
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${jsonDecode(response.body)}');
  // var f = jsonDecode(response.body);
  // print(f['name']);
}
