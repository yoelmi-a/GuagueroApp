import 'package:flutter/material.dart';

class MapPageViewModel extends ChangeNotifier {
  String? _ruta;
  String? _empresa;
  String? get ruta => _ruta;
  String? get empresa => _empresa;

  void setRuta(String newRuta) {
    _ruta = newRuta;
    notifyListeners();
  }
  
  void setEmpresa(String newEmpresa) {
    _empresa = newEmpresa;
    notifyListeners();
  }
}