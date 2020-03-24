import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

class PinApiRetriever {
    Client client = MockClient((request) async {
    final Map<String, dynamic> mockObj = {
      "pinCode": "1234"
    };

      return Response(json.encode(mockObj), 200);
    });

    Future<String> fetchPinCode() async {
      final response = await client.get("localhost:3000/thisIsATest!");
      final parsedJson = json.decode(response.body);

      return Future.delayed(Duration(seconds: 1), () => parsedJson["pinCode"]);
    }
}