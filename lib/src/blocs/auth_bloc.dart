import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/pin_api_retriever.dart';

class AuthBloc {
  final _pinCode = BehaviorSubject<String>();
  final _pinApiRetriever = PinApiRetriever();
  Future<bool> hasPermission;
  bool isPaused;
  bool isStopped;
  Future<Map<PermissionGroup, PermissionStatus>> permissions;

  // Getters for adding to stream
  Function(String) get changePinCode => _pinCode.sink.add;

  // Getters for retrieving data from stream
  Stream<String> get pinCode => _pinCode.stream.transform(validatePinCode());
  Stream<bool> get submitValid => Rx.combineLatest([pinCode], (p) => true);

  AuthBloc() {
    init();
  }

  init() async {
    await requestAudioPermission();
  }

  validatePinCode() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (userPinCode, sink) async {
        // if (userPinCode.length > 3) {
          String successPinCode = await _pinApiRetriever.fetchPinCode();
          // Augment this to compare amongst a list of pin codes
          if (userPinCode == successPinCode) {
            sink.add(userPinCode);
          }
          else {
              sink.addError("Incorrect PIN.");
          }
        // }
      }
    );
  }

  requestAudioPermission() async {
    permissions = PermissionHandler().
      requestPermissions([
        PermissionGroup.microphone
      ]);
  }

  dispose() {
    _pinCode.close();
  }
}