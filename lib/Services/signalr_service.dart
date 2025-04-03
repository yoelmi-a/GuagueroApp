import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRService with ChangeNotifier {
  late final HubConnection _hubConnection;
  // Variable para almacenar los arrivals recibidos
  List<dynamic> arrivals = [];

  // Constructor: recibe la URL del servidor
  SignalRService({required String serverUrl}) {
    _hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  // Método para iniciar la conexión y registrar los handlers
  Future<void> startConnection() async {
    print("Iniciando conexión a SignalR...");
    try {
      // Manejador para la desconexión
      _hubConnection.onclose((error) {
        if (error != null) {
          print("Conexión cerrada con error: $error");
        } else {
          print("Conexión cerrada.");
        }
        // Cuando se cierra la conexión, apagamos el listener de NotifyArrivals
        stopNotifyArrivalsListener();
      });

      // Manejador para errores enviados desde el servidor
      _hubConnection.on("Error", (arguments) {
        final errorMessage = arguments?[0];
        print("Error recibido del servidor: $errorMessage");
      });

      // Manejador para recibir mensajes de chat
      _hubConnection.on("ReceiveMessage", (arguments) {
        final user = arguments?[0] as String;
        final message = arguments?[1] as String;
        print("Mensaje recibido - $user: $message");
      });

      // Iniciar la conexión
      await _hubConnection.start();
      print("Conexión iniciada correctamente");

      // Iniciar el listener para NotifyArrivals
      startNotifyArrivalsListener();
    } catch (e) {
      print("Error iniciando la conexión: $e");
    }
  }

  // Método que se encarga de registrar el listener para NotifyArrivals
  void startNotifyArrivalsListener() {
    print("Listener para NotifyArrivals ACTIVADO.");
    _hubConnection.on("NotifyArrivals", (arguments) {
      // Se asume que el primer elemento del arreglo arguments contiene la lista de ArrivalDTO
      print("NotifyArrivals recibido: ${arguments.toString()}");
      // Guardamos la información recibida en la variable 'arrivals'
      arrivals = arguments?[0] ?? [];
      // Notificamos a la UI para actualizar la vista
      notifyListeners();
    });
  }

  // Método para detener el listener de NotifyArrivals, en caso de que se requiera
  void stopNotifyArrivalsListener() {
    _hubConnection.off("NotifyArrivals");
    print("Listener para NotifyArrivals DESACTIVADO.");
  }

  // Método para actualizar la posición del viaje, con reconexión si es necesario
  Future<void> updateTravelPosition({
    required String employeeID,
    required String travelID,
    required double travelSpeed,
    required double latitude,
    required double longitude,
    required String connectionID,
  }) async {
    // Verificar el estado de la conexión y reconectar si es necesario
    if (_hubConnection.state != HubConnectionState.connected) {
      try {
        print("La conexión no está establecida. Intentando reconectar...");
        await _hubConnection.start();
        print("Reconexión exitosa.");
      } catch (e) {
        print("Error reconectando a SignalR: $e");
        return; // Salir si no se logra la reconexión
      }
    }

    // Construir el objeto de comando con la estructura esperada en el servidor
    final command = {
      "EmpleoyeeID": employeeID,
      "TravelID": travelID,
      "TravelSpeed": travelSpeed,
      "Coordinate": {"Lat": latitude, "Lng": longitude},
      "ConnectionID": connectionID,
    };

    try {
      // Invoca el método UpdateTravelPosition en el servidor enviando el objeto command
      await _hubConnection.invoke("UpdateTravelPosition", args: [command]);
      print("Travel position updated successfully");
    } catch (error) {
      print("Error updating travel position: $error");
    }
  }
}
