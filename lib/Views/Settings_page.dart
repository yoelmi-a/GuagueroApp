import 'package:flutter/material.dart';
import 'package:guaguero/Views/map_page.dart';
import 'package:guaguero/Views/Account_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
                flex: 4,
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
                            Icons.settings,
                            size: 125,
                            color: accentColor,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'CONFIGURACIÓN\n',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                            height: 0.8,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'GENERAL',
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
                top: 280.0, // Match the top position from AccountPage
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
                  constraints: const BoxConstraints(
                    minHeight: 150,
                  ), // Match the height constraint
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          onPressed: () {
                            // Add functionality for dark mode toggle here
                          },
                          child: const Text(
                            'Modo Oscuro',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 50.0, // Increase height to add more space
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Cambiar Datos',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width:
                                double
                                    .infinity, // Match the width of "Modo Oscuro" button
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
                              onPressed: () {
                                // Add functionality for changing password here
                              },
                              child: const Text(
                                'Contraseña',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ), // Add spacing between buttons
                          SizedBox(
                            width:
                                double
                                    .infinity, // Match the width of "Modo Oscuro" button
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
                              onPressed: () {
                                // Add functionality for changing email here
                              },
                              child: const Text(
                                'Correo',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
              icon: const Icon(
                Icons.person,
                size: 45,
                color: accentColor,
              ), // Move "Cuenta" to the middle
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                size: 45,
                color: accentColor,
              ), // Move "Configuración" to the right
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
