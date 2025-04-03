import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guaguero/Services/signalr_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:signalr_core/signalr_core.dart';

class MapPageViewModel extends ChangeNotifier {
  String _travelID = '';
  bool _bookIsActive = false;
  LatLng _currentPosition = LatLng(0, 0);
  LatLng _busPosition = LatLng(0, 0);
  bool _loading = true;
  String? _ruta;
  String? _empresa;
  double? _scrollableListSize = 0.07;
  int _parada = 0;
  int _puntoMasCercano = 0;
  String rutaRomana = 'assets/ruta_la_romana_sto_dom.geojson';
  List<LatLng> _routeCoordinates = [];
  List<Marker> _routeMarkers = [];
  LatLng get busPosition => _busPosition;
  bool get bookIsActive => _bookIsActive;
  String get travelID => _travelID;
  bool get loading => _loading;
  LatLng get currentPosition => _currentPosition;
  int get parada => _parada;
  int get puntoMasCercano => _puntoMasCercano;
  List<LatLng> get routeCoordinates => _routeCoordinates;
  List<Marker> get routeMarkers => _routeMarkers;
  String? get ruta => _ruta;
  String? get empresa => _empresa;
  double? get scrollableListSize => _scrollableListSize;

  Future<void> loadGeoJson(String ruta) async {
    final String data = await rootBundle.loadString(ruta);
    final Map<String, dynamic> geoJson = jsonDecode(data);
    final List coordinates = geoJson['features'][0]['geometry']['coordinates'];
    _routeCoordinates =
        coordinates.map<LatLng>((point) {
          final double long = point[0];
          final double lat = point[1];
          return LatLng(lat, long);
        }).toList();

    notifyListeners();
  }

  MapPageViewModel() {
    SignalRService(serverUrl: 'https://localhost:7035/travelHub')
        .startConnection()
        .then((_) {
          print("Conexión a SignalR iniciada correctamente");
        })
        .catchError((error) {
          print("Error al iniciar la conexión a SignalR: $error");
        });
    _getPosition();
  }

  void setRuta(String newRuta) {
    _ruta = newRuta;
    if (newRuta == 'La Romana - Sto.Dom') {
      _travelID = 'F7C2A3D5-1B4E-4D19-8E2F-9F6A3C5B7D1E';
      newRuta = rutaRomana;
      loadGeoJson(newRuta);

      int index = 0;

      final List waypoints = [
        LatLng(18.453213, -69.186487),
        LatLng(18.408742, -69.543151),
        LatLng(18.449958, -69.668553),
        LatLng(18.450846, -69.685045),
      ];

      double closestDistance = double.infinity;
      for(LatLng waypoint in waypoints) {
        index++;
        double distance = Geolocator.distanceBetween(
          _currentPosition.latitude, _currentPosition.longitude, waypoint.latitude, waypoint.longitude);

          if (distance < closestDistance) {
            closestDistance = distance;
            _puntoMasCercano = index;
          }
      }
      
      index = 0;
      _routeMarkers =
          waypoints.map((coordinate) {
            index++;
            final int markerIndex = index;
            return Marker(
              point: coordinate,
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  print('Se ta topando');
                  _parada = markerIndex;
                  setRuta('La Romana - Sto.Dom');
                },
                child: Icon(
                  Icons.local_parking,
                  color: _parada == markerIndex ? Colors.red : index == _puntoMasCercano ? Colors.green : Colors.blue,
                  size: 40,
                ),
              ),
            );
          }).toList();
    } else {
      _routeMarkers = []; // Clear previous markers
      _routeCoordinates = []; // Clear previous coordinates
    }
    notifyListeners();
  }

 Future<void> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los Servicios de ubicación están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los servicios de ubicación están denegados.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Los servicios de ubicación están denegados permanentemente, no podemos solicitar permisos.',
      );
    }

    Position position = await Geolocator.getCurrentPosition();
    _currentPosition = LatLng(position.latitude, position.longitude);
    _currentPosition = LatLng(18.451339, -69.662719); //ubicacion en el itla
    _loading = false;
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

  void setBookIsActive() {
    _bookIsActive = true;
    notifyListeners();
  }
}
