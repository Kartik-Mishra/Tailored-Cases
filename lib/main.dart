import 'package:tailored_cases/screens/home.dart';
import 'package:tailored_cases/screens/login.dart';
import 'package:tailored_cases/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => UserProvider.initialize(),
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.white
    ),
    home: ScreensController(),
  )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}








