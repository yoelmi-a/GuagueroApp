import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guaguero/ViewModels/map_page_vm.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapPageViewModel>(context);
    DraggableScrollableController controller = DraggableScrollableController();
    LatLng position =
        viewModel.currentPosition != null
            ? LatLng(
              viewModel.currentPosition!.latitude,
              viewModel.currentPosition!.longitude,
            )
            : LatLng(0, 0);

    return Scaffold(
      body:
          viewModel.loading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: position,
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.Guaguero!.FeriaCientifica',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: position,
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
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: viewModel.routeCoordinates,
                            strokeWidth: 4,
                            color: Colors.red,
                          ),
                        ],
                      ),
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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                214,
                                                10,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'Sichoem',
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
                                          ),
                                        ),
                                      ],
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
                                              'X',
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
                                              'Tiempo \nestimado \nen llegar: ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              '1h 31m',
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
                                                      const Color.fromARGB(
                                                        255,
                                                        255,
                                                        214,
                                                        10,
                                                      ),
                                                  foregroundColor:
                                                      const Color.fromARGB(
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
                                                onPressed: () {
                                                  // Llama al método iniciarViaje del ViewModel
                                                  viewModel.iniciarViaje();

                                                  // Guarda el contexto padre para usarlo más adelante
                                                  final parentContext = context;

                                                  // Muestra el primer AlertDialog
                                                  showDialog(
                                                    context: parentContext,
                                                    builder: (
                                                      BuildContext context,
                                                    ) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            const Color.fromARGB(
                                                              255,
                                                              0,
                                                              29,
                                                              61,
                                                            ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        title: const Text(
                                                          'Viaje Iniciado',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  214,
                                                                  10,
                                                                ),
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        content: const Text(
                                                          'El viaje se ha iniciado correctamente.',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    214,
                                                                    10,
                                                                  ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10,
                                                                    ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                context,
                                                              ).pop();

                                                              // Espera 10 segundos antes de mostrar la segunda alerta
                                                              Future.delayed(
                                                                const Duration(
                                                                  seconds: 5,
                                                                ),
                                                                () {
                                                                  showDialog(
                                                                    context:
                                                                        parentContext,
                                                                    builder: (
                                                                      BuildContext
                                                                      context,
                                                                    ) {
                                                                      // Usamos StatefulBuilder para manejar el estado del Switch
                                                                      bool
                                                                      switchValue =
                                                                          false;
                                                                      return StatefulBuilder(
                                                                        builder: (
                                                                          BuildContext
                                                                          context,
                                                                          StateSetter
                                                                          setState,
                                                                        ) {
                                                                          return AlertDialog(
                                                                            backgroundColor: const Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              29,
                                                                              61,
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                            ),
                                                                            title: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: const [
                                                                                Text(
                                                                                  'Nombre',
                                                                                  style: TextStyle(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      255,
                                                                                      214,
                                                                                      10,
                                                                                    ),
                                                                                    fontSize:
                                                                                        24,
                                                                                    fontWeight:
                                                                                        FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  'Acepto',
                                                                                  style: TextStyle(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      255,
                                                                                      214,
                                                                                      10,
                                                                                    ),
                                                                                    fontSize:
                                                                                        24,
                                                                                    fontWeight:
                                                                                        FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            content: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Expanded(
                                                                                  child: Text(
                                                                                    'Lucas',
                                                                                    style: TextStyle(
                                                                                      color:
                                                                                          Colors.white,
                                                                                      fontSize:
                                                                                          20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Switch(
                                                                                  value:
                                                                                      switchValue,
                                                                                  activeColor: const Color.fromARGB(
                                                                                    255,
                                                                                    255,
                                                                                    214,
                                                                                    10,
                                                                                  ),
                                                                                  onChanged: (
                                                                                    bool newValue,
                                                                                  ) {
                                                                                    setState(
                                                                                      () {
                                                                                        switchValue =
                                                                                            newValue;
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                  backgroundColor: const Color.fromARGB(
                                                                                    255,
                                                                                    255,
                                                                                    214,
                                                                                    10,
                                                                                  ),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      10,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(
                                                                                    context,
                                                                                  ).pop();
                                                                                },
                                                                                child: const Text(
                                                                                  'Aceptar',
                                                                                  style: TextStyle(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      0,
                                                                                      29,
                                                                                      61,
                                                                                    ),
                                                                                    fontSize:
                                                                                        20,
                                                                                    fontWeight:
                                                                                        FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: const Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      0,
                                                                      29,
                                                                      61,
                                                                    ),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'Iniciar viaje',
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
