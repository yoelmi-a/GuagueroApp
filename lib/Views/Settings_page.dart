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
                top: 280.0,
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
                            // Funcionalidad para el modo oscuro
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
                        height: 50.0,
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
                            width: double.infinity,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController
                                    currentPasswordController =
                                        TextEditingController();
                                    TextEditingController
                                    newPasswordController =
                                        TextEditingController();
                                    TextEditingController
                                    confirmPasswordController =
                                        TextEditingController();
                                    bool obscureCurrent = true;
                                    bool obscureNew = true;
                                    bool obscureConfirm = true;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: const EdgeInsets.symmetric(
                                            horizontal: 40.0,
                                          ), // Add padding to avoid touching edges
                                          title: const Text(
                                            'Cambiar Contraseña',
                                          ),
                                          content: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.7, // Set width to 70% of the screen
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      MediaQuery.of(
                                                        context,
                                                      ).viewInsets.bottom,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          currentPasswordController,
                                                      obscureText:
                                                          obscureCurrent,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Contraseña Actual',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureCurrent
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureCurrent =
                                                                  !obscureCurrent;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    TextField(
                                                      controller:
                                                          newPasswordController,
                                                      obscureText: obscureNew,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Nueva Contraseña',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureNew
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureNew =
                                                                  !obscureNew;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    TextField(
                                                      controller:
                                                          confirmPasswordController,
                                                      obscureText:
                                                          obscureConfirm,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Confirmar Contraseña',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureConfirm
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureConfirm =
                                                                  !obscureConfirm;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFFFC400),
                                                    foregroundColor:
                                                        Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8.0,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 14.0,
                                                        ),
                                                  ),
                                                  onPressed: () {
                                                    String currentPassword =
                                                        currentPasswordController
                                                            .text;
                                                    String newPassword =
                                                        newPasswordController
                                                            .text;
                                                    String confirmPassword =
                                                        confirmPasswordController
                                                            .text;
                                                    // Logic to save the new password
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    '  Guarda Nueva Contraseña  ',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (
                                                        BuildContext context,
                                                      ) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Recuperación de contraseña',
                                                          ),
                                                          content: const Text(
                                                            'Te enviamos un correo para restablecer tu contraseña.',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                  context,
                                                                ).pop();
                                                              },
                                                              child: const Text(
                                                                'Aceptar',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    '¿Olvidaste tu contraseña?',
                                                    style: TextStyle(
                                                      color: Color(0xFFFFC400),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
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
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController
                                    currentEmailController =
                                        TextEditingController();
                                    TextEditingController newEmailController =
                                        TextEditingController();
                                    TextEditingController
                                    confirmEmailController =
                                        TextEditingController();
                                    bool obscureCurrentEmail = true;
                                    bool obscureNewEmail = true;
                                    bool obscureConfirmEmail = true;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: const EdgeInsets.symmetric(
                                            horizontal: 40.0,
                                          ), // Add padding to avoid touching edges
                                          title: const Text('Cambiar Correo'),
                                          content: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.7, // Set width to 70% of the screen
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      MediaQuery.of(
                                                        context,
                                                      ).viewInsets.bottom,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          currentEmailController,
                                                      obscureText:
                                                          obscureCurrentEmail,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Correo Actual',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureCurrentEmail
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureCurrentEmail =
                                                                  !obscureCurrentEmail;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    TextField(
                                                      controller:
                                                          newEmailController,
                                                      obscureText:
                                                          obscureNewEmail,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Nuevo Correo',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureNewEmail
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureNewEmail =
                                                                  !obscureNewEmail;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    TextField(
                                                      controller:
                                                          confirmEmailController,
                                                      obscureText:
                                                          obscureConfirmEmail,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration: InputDecoration(
                                                        labelText:
                                                            'Confirmar Correo',
                                                        labelStyle:
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            obscureConfirmEmail
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              obscureConfirmEmail =
                                                                  !obscureConfirmEmail;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFFFC400),
                                                    foregroundColor:
                                                        Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8.0,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 14.0,
                                                        ),
                                                  ),
                                                  onPressed: () {
                                                    String currentEmail =
                                                        currentEmailController
                                                            .text;
                                                    String newEmail =
                                                        newEmailController.text;
                                                    String confirmEmail =
                                                        confirmEmailController
                                                            .text;
                                                    // Logic to save the new email
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    '  Guardar Nuevo Correo  ',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (
                                                        BuildContext context,
                                                      ) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Recuperación de correo',
                                                          ),
                                                          content: const Text(
                                                            'Te enviamos instrucciones para recuperar tu correo.',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                  context,
                                                                ).pop();
                                                              },
                                                              child: const Text(
                                                                'Aceptar',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    '¿Problemas con tu correo?',
                                                    style: TextStyle(
                                                      color: Color(0xFFFFC400),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
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
              icon: const Icon(Icons.person, size: 45, color: accentColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, size: 45, color: accentColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
