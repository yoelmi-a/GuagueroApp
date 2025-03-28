import 'package:flutter/material.dart';
import 'package:guaguero/ViewModels/map_page_vm.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your providers here
        ChangeNotifierProvider<MapPageViewModel>(
          create: (_) => MapPageViewModel(),
        ),
      ],
      child: child,
    );
  }

}