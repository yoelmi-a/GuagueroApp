import 'package:flutter/material.dart';
import 'package:guaguero/Config/app_theme.dart';
import 'package:guaguero/Providers/providers.dart';
import 'package:guaguero/Routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'Map Page',
        theme: AppTheme.lightTheme,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.mapPage,
      ),
    );
  }
}
