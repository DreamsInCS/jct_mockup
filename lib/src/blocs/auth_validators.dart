import 'dart:async';
import 'package:jct_mockup/src/resources/email_api_retriever.dart';
import 'package:jct_mockup/src/resources/pin_api_retriever.dart';

class AuthValidators {
  static final _emailApiRetriever = EmailApiRetriever();
  static final _pinApiRetriever = PinApiRetriever();

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (userEmail, sink) async {
      if (userEmail.contains('@')) {
        List<String> emailList = await _emailApiRetriever.fetchEmail();

        for (String successEmail in emailList) {
          if (userEmail == successEmail) {
            sink.add(userEmail);
            return;
          }
        }
        sink.addError("Invalid email.");
      }
    }
  );

  final validatePinCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (userPinCode, sink) async {
      // print('validatePinCode(): userPinCode is $userPinCode.');
      List<String> pinCodeList = await _pinApiRetriever.fetchPinCode();

      for (String successPinCode in pinCodeList) {
        if (userPinCode == successPinCode) {
          sink.add(userPinCode);
          return;
        }
      }

      sink.addError("The PIN entered is incorrect.");
    }
  );
}