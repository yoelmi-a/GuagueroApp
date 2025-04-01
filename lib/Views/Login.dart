import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscurecontasenialog = true;
    return Scaffold(
      backgroundColor: Color.fromARGB(242, 0, 29, 61),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bus_alert_rounded,
                    size: 140,
                    color: Color.fromARGB(255, 255, 214, 10),
                  ),
                  const Text(
                    "BIENVENIDO \nA BORDO",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 255, 214, 10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.grey[100]),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    hintText: 'Ingrese su nombre correo electrónico',
                    hintStyle: TextStyle(color: Colors.grey[100]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 214, 10),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 214, 10),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 214, 10),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      obscureText: obscurecontasenialog,
                      style: TextStyle(color: Colors.grey[100]),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurecontasenialog = !obscurecontasenialog;
                            });
                          },
                          icon: Icon(
                            obscurecontasenialog
                                ? Icons.visibility_off
                                : Icons.visibility,

                            color: Colors.white,
                          ),
                        ),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.grey[100]),
                        hintText: 'Ingrese su contraseña',
                        hintStyle: TextStyle(color: Colors.grey[100]),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 214, 10),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 214, 10),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 214, 10),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                      255,
                      255,
                      214,
                      10,
                    ), // Color del botón
                    foregroundColor: Color.fromARGB(
                      242,
                      0,
                      29,
                      61,
                    ), // Color del texto
                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    print("Formulario enviado");
                  },
                  child: Text("Iniciar Sesión"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
