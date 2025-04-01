import 'package:flutter/material.dart';
import 'package:guaguero/Views/Login.dart';
import 'package:guaguero/Views/Registro.dart';
import 'package:guaguero/Views/map_page.dart';

class Routes {
  static const String mapPage = '/mapPage';
  static const String registropage = '/Registro';
  static const String loginpage = '/Loggin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapPage:
        return MaterialPageRoute(builder: (_) => const MapPage());

      case registropage:
        return MaterialPageRoute(builder: (_) => const Registro());

      case loginpage:
        return MaterialPageRoute(builder: (_) => const Login());

      default:
        return MaterialPageRoute(builder: (_) => const MapPage());
    }
  }
}
