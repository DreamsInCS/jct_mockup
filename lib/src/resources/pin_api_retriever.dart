import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class PinApiRetriever {
    Client client = MockClient((request) async {
    final List<Map<String, dynamic>> mockPinList = [
      { 'pinCode': '1234' },
      { 'pinCode': '5678' },
    ];

      return Response(json.encode(mockPinList), 200);
    });

    Future<List<String>> fetchPinCode() async {
      final response = await client.get('localhost:3000/thisIsATest!');
      final parsedJson = jsonDecode(response.body);
      final List<String> pinCodeList = List();

      for (Map<String, dynamic> json in parsedJson) {
        pinCodeList.add(json['pinCode']);
      }

      return Future.delayed(Duration(seconds: 1), () => pinCodeList);
    }
}