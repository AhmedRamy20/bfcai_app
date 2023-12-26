//main.dart
// import 'package:bfcai_app/screens/home_screen.dart';
import 'package:bfcai_app/app_router.dart';
import 'package:flutter/material.dart';
// import 'package:bfcai/screens/home_screen.dart';

void main() {
  runApp(MyApp(routerApp: RouterApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routerApp});
  final RouterApp routerApp;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routerApp.generateRoute,
    );
  }
}
