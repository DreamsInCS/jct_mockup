import 'package:flutter/material.dart';
import 'blocs/auth_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard.dart';
import 'screens/listen_screen.dart';
import 'screens/perform_screen.dart';

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
            return Dashboard();
            // return PerformScreen();
          }
        );

      case "/auth":
        return MaterialPageRoute(
          builder: (context) {
            return AuthProvider(
              child: AuthScreen()
            );
          }
        );

      case "/perform":
        return MaterialPageRoute(
          builder: (context) {
            return PerformScreen();
          }
        );

      case "/listen":
        return MaterialPageRoute(
          builder: (context) {
            return ListenScreen();
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