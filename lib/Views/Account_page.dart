import 'package:flutter/material.dart';
import 'package:guaguero/Config/app_theme.dart';
import 'package:guaguero/Views/map_page.dart'; // Import the MapPage

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 1, 36, 75);
    const Color accentColor = Color(0xFFFFC400);
    const Color backgroundColor = Color(0xFFF9F9F9);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(elevation: 0, backgroundColor: primaryColor),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex:
                    4, // Incrementa el valor de flex para que cubra más espacio
                child: Container(
                  color: primaryColor,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.directions_bus,
                            size: 125,
                            color: accentColor,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  // Texto "MI PERFIL" superpuesto
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'MI\n',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                            height:
                                                0.8, // Ajuste fino de espaciado
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: 8.0,
                                            ), // Ajuste para bajar "PERFIL"
                                            child: Text(
                                              'PERFIL',
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                height: 0.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'YOELMI ALEXANDER',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  color: backgroundColor,
                ),
              ),
            ],
          ),
          Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top:
                    280.0, // Adjust this value to position the container correctly
                left: 20.0,
                right: 20.0,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 1, 36, 75),
                      width: 2.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(95, 0, 0, 0),
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minHeight: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ), // Add spacing above "TELÉFONO"
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone,
                            color: accentColor,
                            size: 30,
                          ), // Increase icon size
                          const SizedBox(width: 12.0), // Adjust spacing
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'TELÉFONO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Increase font size
                                ),
                              ),
                              Text(
                                '809-000-2288',
                                style: TextStyle(
                                  fontSize: 16,
                                ), // Increase font size
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 32.0), // Adjust spacing
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            color: accentColor,
                            size: 30,
                          ), // Increase icon size
                          const SizedBox(width: 12.0), // Adjust spacing
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'CORREO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Increase font size
                                ),
                              ),
                              Text(
                                'Ejemplo@gmail.com',
                                style: TextStyle(
                                  fontSize: 16,
                                ), // Increase font size
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 130,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Cerrar Sesión',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Flexible(
                            // Use Flexible to ensure proper alignment and responsiveness
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                '  Cambiar Contraseña  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 29), // Adjust spacing between buttons
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 45, color: accentColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, size: 45, color: accentColor),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 45, color: accentColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
