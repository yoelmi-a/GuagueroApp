import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guaguero/Config/app_theme.dart';
import 'package:guaguero/Providers/providers.dart';
import 'package:guaguero/Routes/routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // Configuración para omitir la verificación de certificados (solo en desarrollo)
  HttpOverrides.global = MyHttpOverrides();
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
