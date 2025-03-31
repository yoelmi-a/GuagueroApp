import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guaguero/ViewModels/map_page_vm.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

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
    final viewModel = Provider.of<MapPageViewModel>(context);
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
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            top: 0,
            child: DraggableScrollableSheet(
              initialChildSize: 0.07,
              minChildSize: 0.07,
              maxChildSize: 0.7,
              expand: false,
              snap: true,
              snapAnimationDuration: const Duration(milliseconds: 200),
              snapSizes: [0.07, 0.7],
              builder: (BuildContext context, ScrollController scrollController){
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 29, 61),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Bienvenido Nombre!',
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.w600, 
                            color: Color.fromARGB(255, 255, 214, 10)),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Saldo Actual:  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            ),
                            Text(
                              '\$1000',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 214, 10)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 214, 10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: viewModel.empresa,
                              items: ['Sichoem', 'Aptra', 'Caribe Tours']
                                .map((String empresa) => DropdownMenuItem<String>(
                                  value: empresa,
                                  child: Text(empresa, 
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 29, 61),
                                    ),
                                  ),
                                )).toList(),
                              onChanged: (String? newEmpresa) {
                                if (newEmpresa != null) {
                                  viewModel.setEmpresa(newEmpresa);
                                }
                              },
                              hint: const Text("Seleccione la empresa",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 29, 61),
                                  fontSize: 20,
                                ),
                              ),
                              icon: const FaIcon(FontAwesomeIcons.angleDown,
                                color: Color.fromARGB(255, 0, 29, 61),
                                size: 20,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: Color.fromARGB(255, 255, 214, 10),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 29, 61),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 214, 10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              value: viewModel.ruta,
                              items: ['La Romana - Sto.Dom', 'Ruta 2', 'Ruta 3']
                                .map((String ruta) => DropdownMenuItem<String>(
                                  value: ruta,
                                  child: Text(ruta,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 29, 61),
                                    ),),
                                )).toList(),
                              onChanged: (String? newRuta) {
                                if (newRuta != null) {
                                  viewModel.setRuta(newRuta);
                                }
                              },
                              hint: const Text("Seleccione la ruta",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 29, 61),
                                  fontSize: 20,
                                ),
                              ),
                              icon: const FaIcon(FontAwesomeIcons.angleDown,
                                color: Color.fromARGB(255, 0, 29, 61),
                                size: 20,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: Color.fromARGB(255, 255, 214, 10),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 29, 61),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Costo: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  ),
                                  Text('\$275',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 214, 10)),
                                  ),
                                  const Text(' pesos',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text('Hay ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  ),
                                  Text('X',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 214, 10)),
                                  ),
                                  const Text(' Asientos disponibles',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text('Tiempo \nestimado \nen llegar: ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  ),
                                  const SizedBox(width: 20),
                                  Text('1h 31m',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 214, 10)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 255, 214, 10),
                                        foregroundColor: Color.fromARGB(255, 0, 29, 61),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      ),
                                      onPressed: () {}, 
                                      child: Text('Reservar asiento',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
          )
        ],
      )
    );
  }
}