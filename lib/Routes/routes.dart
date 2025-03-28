import 'package:flutter/material.dart';
import 'package:guaguero/Views/map_page.dart';

class Routes {
  static const String mapPage = '/mapPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case mapPage:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
            );
    }
  }
}