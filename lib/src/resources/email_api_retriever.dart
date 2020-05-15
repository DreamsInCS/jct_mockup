import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class EmailApiRetriever {
  Client client = MockClient((request) async {
    final List<Map<String, dynamic>> mockEmailList = [
      { 'email': 'dummytest123@gmail.com' },
      { 'email': 'rickleinecker@hotmail.com' },
    ];

    return Response(jsonEncode(mockEmailList), 200);
  });

  Future<List<String>> fetchEmail() async {
    final response = await client.get('localhost:3000/TypeAnythingHere!');
    final parsedJson = jsonDecode(response.body);
    final List<String> emailList = List();

    for (Map<String, dynamic> json in parsedJson) {
      emailList.add(json['email']);
    }

    return Future.delayed(Duration(seconds: 1), () => emailList);
  }
}