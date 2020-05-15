import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../blocs/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = AuthProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          
          return Padding(
          padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Text('Please enter your composer\'s email beloww:'),
                emailField(bloc),
                pinCodeMessage(bloc),
                Center(
                  child: PinPut(
                    fieldsCount: 4,
                    controller: null,
                    followingFieldDecoration: pinPutBoxEnteredData(),
                    selectedFieldDecoration: pinPutBoxSubmittedData(),
                    submittedFieldDecoration: pinPutBoxEnteringData(),
                    onSubmit: bloc.changePinCode,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 40.0)),
                submitButton(bloc),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget pinCodeMessage(AuthBloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: StreamBuilder(
        stream: bloc.pinCode,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.hasError) {
              return Text(snapshot.error,
                style: TextStyle(color: Colors.red)
              );
            } else {
            return Text('Please enter your PIN code below:');
            }
          }
          
          return Text('');
        }
      )
    );
  }

  Widget submitButton(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData
            ? () => snackAndCanPerform(context, true)
            : null,
          color: Colors.blue,
          textColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          child: Text('Enter Session'),
        );
      }
    );
  }

  Widget emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Container(
          margin: EdgeInsets.all(20.0),
          child: TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter the appointment maker\'s email.',
              labelText: 'Email Address',
              errorText: snapshot.error,
            ),
          ),
        );
      }
    );
  }

  void snackAndCanPerform(BuildContext context, bool success) async {
    int waitTime = 1000; // milliseconds

    if (success) {
      await _showSnackBar(context, true, waitTime);
      Navigator.pushNamed(context, '/perform');
    } else {
      waitTime = 2000;
      await _showSnackBar(context, false, waitTime);
    }
  }

  BoxDecoration pinPutBoxEnteredData() {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(5)
    );
  }

  BoxDecoration pinPutBoxEnteringData() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15),
    );
  }

  BoxDecoration pinPutBoxSubmittedData() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    );
  }

  // void verifyCode(String pin, BuildContext context) async {
  //   int waitTime = 1000; // milliseconds
  //   bool success;

  //   if (pin == "1234") {
  //     success = true;
  //     await _showSnackBar(context, success, waitTime);
  //     Navigator.pushNamed(context, "/perform");
  //   } else if (pin == "5678") {
  //     success = true;
  //     await _showSnackBar(context, success, waitTime);
  //     Navigator.pushNamed(context, "/listen");
  //   }
    
  //   success = false;
  //   waitTime = 2000;
  //   return _showSnackBar(context, success, waitTime);
  // }

  _showSnackBar(BuildContext context, bool success, int waitTime) async {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: waitTime),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            (success 
              ? "Authentication successful!" 
              : "The info entered was invalid."),
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