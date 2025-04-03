import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guaguero/Services/signalr_service.dart';
import 'package:guaguero/ViewModels/map_page_vm.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapPageViewModel>(context, listen: true);
    DraggableScrollableController controller = DraggableScrollableController();

    return Scaffold(
      body:
          viewModel.loading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: viewModel.currentPosition,
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.Guaguero!.FeriaCientifica',
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: viewModel.routeCoordinates,
                            strokeWidth: 4,
                            color: Colors.lightBlue.shade700,
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: viewModel.currentPosition,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      MarkerLayer(markers: viewModel.routeMarkers),
                      MarkerLayer(
                        markers: viewModel.bookIsActive ?
                        [
                          Marker(
                            point: viewModel.busPosition,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ] : [],
                        )
                    ],
                  ),
                  Positioned(
                    right: 16,
                    bottom: 80,
                    child: FloatingActionButton(
                      child: const Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 255, 214, 10),
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settingsPage');
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    top: 0,
                    child: DraggableScrollableSheet(
                      controller: controller,
                      initialChildSize: 0.07,
                      minChildSize: 0.07,
                      maxChildSize: 0.7,
                      expand: false,
                      snap: true,
                      snapAnimationDuration: const Duration(milliseconds: 200),
                      snapSizes: [0.07, 0.7],
                      builder: (
                        BuildContext context,
                        ScrollController scrollController,
                      ) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 29, 61),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.size == 0.07) {
                                controller.animateTo(
                                  0.7,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                controller.animateTo(
                                  0.07,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
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
                                      color: Color.fromARGB(255, 255, 214, 10),
                                    ),
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
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '\$1000',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            214,
                                            10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 15,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          214,
                                          10,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: viewModel.empresa,
                                        items:
                                            ['Sichoem', 'Aptra', 'Caribe Tours']
                                                .map(
                                                  (String empresa) =>
                                                      DropdownMenuItem<String>(
                                                        value: empresa,
                                                        child: Text(
                                                          empresa,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  29,
                                                                  61,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                .toList(),
                                        onChanged: (String? newEmpresa) {
                                          if (newEmpresa != null) {
                                            viewModel.setEmpresa(newEmpresa);
                                          }
                                        },
                                        hint: const Text(
                                          "Seleccione la empresa",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                              255,
                                              0,
                                              29,
                                              61,
                                            ),
                                            fontSize: 20,
                                          ),
                                        ),
                                        icon: const FaIcon(
                                          FontAwesomeIcons.angleDown,
                                          color: Color.fromARGB(255, 0, 29, 61),
                                          size: 20,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        dropdownColor: Color.fromARGB(
                                          255,
                                          255,
                                          214,
                                          10,
                                        ),
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 29, 61),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 15,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          214,
                                          10,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        value: viewModel.ruta,
                                        items:
                                            [
                                                  'La Romana - Sto.Dom',
                                                  'Sto.Dom - Santiago',
                                                ]
                                                .map(
                                                  (String ruta) =>
                                                      DropdownMenuItem<String>(
                                                        value: ruta,
                                                        child: Text(
                                                          ruta,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  29,
                                                                  61,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                .toList(),
                                        onChanged: (String? newRuta) {
                                          if (newRuta != null) {
                                            viewModel.setRuta(newRuta);
                                          }
                                        },
                                        hint: const Text(
                                          "Seleccione la ruta",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                              255,
                                              0,
                                              29,
                                              61,
                                            ),
                                            fontSize: 20,
                                          ),
                                        ),
                                        icon: const FaIcon(
                                          FontAwesomeIcons.angleDown,
                                          color: Color.fromARGB(255, 0, 29, 61),
                                          size: 20,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        dropdownColor: Color.fromARGB(
                                          255,
                                          255,
                                          214,
                                          10,
                                        ),
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 29, 61),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 15,
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.grey[100]),
                                      decoration: InputDecoration(
                                        labelText: 'Asientos',
                                        labelStyle: TextStyle(
                                          color: Colors.grey[100],
                                        ),
                                        hintText:
                                            '1',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[100],
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              214,
                                              10,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                    
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              214,
                                              10,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                    
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              214,
                                              10,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: 15,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Costo: ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '\$275',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  214,
                                                  10,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              ' pesos',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text(
                                              'Hay ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '5',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  214,
                                                  10,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              ' Asientos disponibles',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            const SizedBox(width: 20),
                                            const Text(
                                              'Ultima \nSalida: ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              '2:30 PM',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  214,
                                                  10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                        255,
                                                        255,
                                                        214,
                                                        10,
                                                      ),
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                        255,
                                                        0,
                                                        29,
                                                        61,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 15,
                                                      ),
                                                ),
                                                onPressed: () async {
                                                  // Simulated data
                                                  viewModel.setBookIsActive();
                                                  final signalRService =
                                                      Provider.of<
                                                        SignalRService
                                                      >(context, listen: false);
                                                  // Create a reservation using the travelId
                                                  await signalRService.createReservation(
                                                    travelID:
                                                        viewModel
                                                            .travelID, // Simulated data
                                                    customerID:
                                                        'A3F47C2B-1B3D-4E19-8E2A-3D9F7C5A1D5E', // Simulated data
                                                    entryStep:
                                                        viewModel.parada == 0
                                                            ? viewModel
                                                                .puntoMasCercano
                                                            : viewModel
                                                                .parada, // Simulated data
                                                    seatsQuantity:
                                                        1, // Simulated data
                                                    paymentType:
                                                        "Credit", // Simulated data
                                                  );
                                                  // Subscribe to travel updates for the same travelId
                                                  await signalRService
                                                      .suscribeToTravel(
                                                        viewModel.travelID,
                                                      );
                                                  // Optionally, show a confirmation Snackbar
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Reserva creada y suscripción enviada",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Reservar asiento',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
