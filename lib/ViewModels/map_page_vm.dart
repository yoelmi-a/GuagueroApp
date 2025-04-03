import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:guaguero/Services/signalr_service.dart';

class MapPageViewModel extends ChangeNotifier {
  String? _ruta;
  String? _empresa;
  double? _scrollableListSize = 0.07;
  bool _loading = true;
  String rutaRomana = 'assets/ruta_la_romana_sto_dom.geojson';
  List<LatLng> _routeCoordinates = [];
  List<Marker> _routeMarkers = [];
  LatLng? _currentPosition;
  StreamSubscription<Position>? _streamSubscription;

  // Instancia de SignalRService
  late final SignalRService _signalRService;

  bool get loading => _loading;
  LatLng? get currentPosition => _currentPosition;
  List<LatLng> get routeCoordinates => _routeCoordinates;
  List<Marker> get routeMarkers => _routeMarkers;
  String? get ruta => _ruta;
  String? get empresa => _empresa;
  double? get scrollableListSize => _scrollableListSize;

  MapPageViewModel() {
    _init();
    // Instanciar y conectar SignalRService
    _signalRService = SignalRService(
      serverUrl: 'https://10.0.2.2:7035/travelHub',
    );
    _signalRService
        .startConnection()
        .then((_) {
          print("Conexión a SignalR iniciada correctamente");
        })
        .catchError((error) {
          print("Error al iniciar la conexión a SignalR: $error");
        });
  }

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

  Future<void> _init() async {
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

    // Suscribirse al stream de posiciones
    _streamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    ).listen((Position position) {
      _currentPosition = LatLng(18.432710, -68.994845);
      _loading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void setRuta(String newRuta) {
    _ruta = newRuta;
    if (newRuta == 'La Romana - Sto.Dom') {
      newRuta = rutaRomana;
      loadGeoJson(newRuta);

      final List waypoints = [
        LatLng(18.408742, -69.543151),
        LatLng(18.453213, -69.186487),
        LatLng(18.449958, -69.668553),
        LatLng(18.450846, -69.685045),
      ];

      _routeMarkers =
          waypoints.map((coordinate) {
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
    } else {
      _routeMarkers = []; // Limpia los marcadores anteriores
      _routeCoordinates = []; // Limpia las coordenadas anteriores
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

  /// Método para iniciar el viaje manualmente
  void iniciarViaje() {
    if (_currentPosition != null) {
      _signalRService.updateTravelPosition(
        employeeID: "D5F1A8E7-4C6B-49F2-B7D9-65E3C7F9B2A1",
        travelID: "F7C2A3D5-1B4E-4D19-8E2F-9F6A3C5B7D1E",
        travelSpeed: 80.0,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        connectionID: " ",
      );
      print("Viaje iniciado: se envió la posición actual.");
    } else {
      print("No se pudo iniciar el viaje: posición actual no disponible.");
    }
  }
}
