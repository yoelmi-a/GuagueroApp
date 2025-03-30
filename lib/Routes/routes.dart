import 'package:flutter/material.dart';
import 'package:guaguero/Views/map_page.dart';
import 'package:guaguero/Views/Account_page.dart';
import 'package:guaguero/Views/Settings_page.dart';

class Routes {
  static const String mapPage = '/mapPage';
  static const String accountPage = '/accountPage';
  static const String settingsPage = '/settingsPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case mapPage:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
        );
      case accountPage:
        return MaterialPageRoute(
          builder: (_) => const AccountPage(),
        );
        case settingsPage:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
            );
    }
  }
}