import 'package:flutter/material.dart';
import 'blocs/auth_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard.dart';
import 'screens/record_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: "John Cage Tribute",
      onGenerateRoute: routes
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) {
            // return Dashboard();
            return RecordScreen();
          }
        );

      // case "/auth":
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return AuthProvider(
      //         child: AuthScreen()
      //       );
      //     }
      //   );

      case "/record":
        return MaterialPageRoute(
          builder: (context) {
            return RecordScreen();
          }
        );
    
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Text("Bet.");
          }
        );
    }
  }
}