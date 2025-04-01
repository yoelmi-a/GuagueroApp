import 'package:flutter/material.dart';

class MapPageViewModel extends ChangeNotifier {
  String? _ruta;
  String? _empresa;
  double? _scrollableListSize = 0.07;
  String? get ruta => _ruta;
  String? get empresa => _empresa;
  double? get scrollableListSize => _scrollableListSize;

  void setRuta(String newRuta) {
    _ruta = newRuta;
    notifyListeners();
  }
  
  void setEmpresa(String newEmpresa) {
    _empresa = newEmpresa;
    notifyListeners();
  }

  void setScrollableListSize(double newSize) {
    _scrollableListSize = newSize;
    notifyListeners();
  }
}