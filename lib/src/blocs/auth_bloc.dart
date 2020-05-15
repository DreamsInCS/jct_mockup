import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'auth_validators.dart';

class AuthBloc with AuthValidators {
  final _email = BehaviorSubject<String>();
  final _pinCode = BehaviorSubject<String>();

  // Getters for adding to stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePinCode => _pinCode.sink.add;

  // Getters for retrieving data from stream
  Stream<String> get pinCode => _pinCode.stream.transform(validatePinCode);
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<bool> get submitValid => 
    Rx.combineLatest2(pinCode, email, (pin, em) => true);

  // // For reference. Taken from login_bloc's bloc.dart file.
  // submitAndLogin() {
  //   final validEmail = _email.value;
  //   final validPassword = _password.value;

  //   print('Email:    $validEmail');
  //   print('Password: $validPassword');
  // }
  

  dispose() {
    _pinCode.close();
    _email.close();
  }
}