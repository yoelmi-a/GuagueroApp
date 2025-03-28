import 'package:flutter/material.dart';

class MapPageViewModel extends ChangeNotifier {
  // Add your properties and methods here
  // For example:
  String mapType = 'normal';

  void changeMapType(String newType) {
    mapType = newType;
    notifyListeners();
  }
}