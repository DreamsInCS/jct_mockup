import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../blocs/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = AuthProvider.of(context);

    return FutureBuilder(
      future: bloc.permissions,
      builder: (context, AsyncSnapshot<Map<PermissionGroup, PermissionStatus>> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        final PermissionStatus audioPermission = snapshot.data[PermissionGroup.microphone];

        if (audioPermission == PermissionStatus.denied) {
          return Center(
            child: Text("Audio recording permission denied. Please exit the app.")
          );
        }

        return Scaffold(
          body: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: PinPut(
                  fieldsCount: 4,
                  onSubmit: (String pin) => verifyCode(pin, context),
                ),
              ),
            ),
          )
        );
      }
    );
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: Text("Authentication")
    //       ),
    //       body: Column(
    //         children: [
    //           pinCodeField(context),
    //           // submitButton(bloc)
    //         ]
    //       )
    //     );
    //   }
    // );
  }

  void verifyCode(String pin, BuildContext context) async {
    int waitTime = 1000; // milliseconds
    bool success;

    // TODO: HEY, SERVER! WHAT'S THIS USER'S PIN AGAIN?
    if (pin == "1234") {
      success = true;
      await _showSnackBar(pin, context, success, waitTime);
      Navigator.pushNamed(context, "/record");
    }
    
    success = false;
    waitTime = 2000;
    return _showSnackBar(pin, context, success, waitTime);
  }

  _showSnackBar(String pin, BuildContext context, bool success, int waitTime) async {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: waitTime),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            (success ? "PIN successful!" : "$pin is an invalid PIN."),
            style: TextStyle(fontSize: 25.0),
          ),
        )
      ),
      backgroundColor: (success ? Colors.greenAccent: Colors.redAccent[400]),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    // Gives the snackbar some leeway before program runs other code
    if (success) {
      await Future.delayed(Duration(milliseconds: waitTime + 500));
    }
  }
}