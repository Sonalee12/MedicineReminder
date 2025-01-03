import 'package:flutter/material.dart';
import 'view/register.dart';
import 'view/login.dart';
import 'view/profile.dart ';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MVC',
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        // '/homepage': (context) => HomePage(),
        // '/profile': (context) => ProfilePage(),

      },
    );
  }
}
