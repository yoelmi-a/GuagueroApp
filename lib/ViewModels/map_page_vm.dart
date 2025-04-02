import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPageViewModel extends ChangeNotifier {
  String? _ruta;
  String? _empresa;
  double? _scrollableListSize = 0.07;
  String rutaRomana = 'assets/ruta_la_romana_sto_dom.geojson';
  List<LatLng> _routeCoordinates = [];
  List<Marker> _routeMarkers = [];
  List<LatLng> get routeCoordinates => _routeCoordinates;
  List<Marker> get routeMarkers => _routeMarkers;
  String? get ruta => _ruta;
  String? get empresa => _empresa;
  double? get scrollableListSize => _scrollableListSize;

  Future<void> loadGeoJson(String ruta) async {
    final String data = await rootBundle.loadString(ruta);
    final Map<String, dynamic> geoJson = jsonDecode(data);
    final List coordinates = geoJson['features'][0]['geometry']['coordinates'];
    _routeCoordinates = coordinates.map<LatLng>((point) {
      final double long = point[0];
      final double lat = point[1];
      return LatLng(lat, long);
    }).toList();

    notifyListeners();
  }

  void setRuta(String newRuta) {
    _ruta = newRuta;
    if (newRuta == 'La Romana - Sto.Dom') {
      newRuta = rutaRomana;
      loadGeoJson(newRuta);

      final List waypoints = [
        LatLng(18.408742,-69.543151),
        LatLng(18.453213,-69.186487),
        LatLng(18.449958,-69.668553),
        LatLng(18.450846,-69.685045)
      ];

      _routeMarkers = waypoints.map((coordinate) {
        return Marker(
          point: coordinate,
          width: 40,
          height: 40,
          child: const Icon(
            Icons.location_on_rounded,
            color: Colors.red,
            size: 40,
          ),
        );
      }).toList();
    }
    else {
      _routeMarkers = []; // Clear previous markers
      _routeCoordinates = []; // Clear previous coordinates
    }
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