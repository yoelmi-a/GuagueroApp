import 'package:flutter/material.dart';
import 'package:guaguero/Config/app_theme.dart';
import 'package:guaguero/Providers/providers.dart';
import 'package:guaguero/Routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:guaguero/Services/signalr_service.dart';

void main() {
  print("Iniciando la aplicación...");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // URL de tu servidor SignalR
  final String signalRServerUrl = 'https://localhost:7035/travelHub';

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<SignalRService>(
            create:
                (_) =>
                    SignalRService(serverUrl: signalRServerUrl)
                      ..startConnection(),
          ),
          // Agrega otros providers si lo necesitas.
        ],
        child: MaterialApp(
          title: 'Map Page',
          theme: AppTheme.lightTheme,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.mapPage,
        ),
      ),
    );
  }
}
