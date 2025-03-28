import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget{
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _currentPosition = LatLng(0, 0);
  bool _loading = true;

  @override
  void initState(){
    super.initState();
    _getPosition();
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
          'Los servicios de ubicación están denegados permanentemente, no podemos solicitar permisos.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    final List<LatLng> rutaLosAngeles = [
      LatLng(34.052235, -118.243683), // Downtown LA
      LatLng(34.057235, -118.245683),
      LatLng(34.062235, -118.250683),
      LatLng(34.067235, -118.255683),
      LatLng(34.072235, -118.260683),
    ];
    return Scaffold(
      body: _loading 
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 13.0
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.Guaguero!.FeriaCientifica',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: LatLng(34.052235, -118.243683),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: LatLng(34.057235, -118.245683),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: LatLng(34.062235, -118.250683),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: LatLng(34.067235, -118.255683),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: LatLng(34.072235, -118.260683),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                  )
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: rutaLosAngeles,
                    strokeWidth: 7.0,
                    color: Colors.red
                  )
                ])
            ]
          )
        ],
      )
    );
  }
}