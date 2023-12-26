import 'package:bfcai_app/constents/routes.dart';
import 'package:bfcai_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RouterApp {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeMovies:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}


//! Did not apply it