import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscurecontrasenia = true;
    bool obscureconfirmar = true;
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
                  Text(
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
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Ingrese su nombre completo',
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
                child: TextField(
                  style: TextStyle(color: Colors.grey[100]),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Nombre de Usuario',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    hintText: 'Ingrese su nombre de usuario',
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
                child: TextField(
                  style: TextStyle(color: Colors.grey[100]),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    hintText: 'Ingrese su correo electronico',
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
                      obscureText: obscurecontrasenia,
                      style: TextStyle(color: Colors.grey[100]),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurecontrasenia = !obscurecontrasenia;
                            });
                          },
                          icon: Icon(
                            obscurecontrasenia
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
                  horizontal: 20,
                  vertical: 10,
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      style: TextStyle(color: Colors.grey[100]),
                      obscureText: obscureconfirmar,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureconfirmar = !obscureconfirmar;
                            });
                          },
                          icon: Icon(
                            obscureconfirmar
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                        labelText: ' Confirme su Contraseña',
                        labelStyle: TextStyle(color: Colors.grey[100]),
                        hintText: 'Ingrese su contraseñia otra vez',
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

              //boton
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
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
                  child: Text("Registrarse"),
                ),
              ),

              Row(
                // O usa Column según lo que necesites
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      print("sesión iniciada");
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(
                        255,
                        255,
                        214,
                        10,
                      ), // Color del texto
                    ),
                    child: Text("Iniciar Sesión"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
