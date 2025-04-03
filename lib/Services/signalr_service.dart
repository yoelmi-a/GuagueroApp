import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRService with ChangeNotifier {
  late final HubConnection _hubConnection;

  SignalRService({required String serverUrl}) {
    _hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  // Método para iniciar la conexión y registrar los handlers
  Future<void> startConnection() async {
    print("Iniciando conexión a SignalR...");
    try {
      // Handler para la desconexión
      _hubConnection.onclose((error) {
        if (error != null) {
          print("Conexión cerrada con error: $error");
        } else {
          print("Conexión cerrada.");
        }
      });

      // Handler para errores enviados desde el servidor
      _hubConnection.on("Error", (arguments) {
        final errorMessage = arguments?[0];
        print("Error recibido del servidor: $errorMessage");
      });

      // Handler para mensajes de chat
      _hubConnection.on("ReceiveMessage", (arguments) {
        final user = arguments?[0] as String;
        final message = arguments?[1] as String;
        print("Mensaje recibido - $user: $message");
      });

      await _hubConnection.start();
      print("Conexión iniciada correctamente");
    } catch (e) {
      print("Error iniciando la conexión: $e");
    }
  }

  // Método para actualizar la posición del viaje
  Future<void> updateTravelPosition({
    required String employeeID,
    required String travelID,
    required double travelSpeed,
    required double latitude,
    required double longitude,
    required String connectionID,
  }) async {
    if (_hubConnection.state != HubConnectionState.connected) {
      try {
        print("La conexión no está establecida. Intentando reconectar...");
        await _hubConnection.start();
        print("Reconexión exitosa.");
      } catch (e) {
        print("Error reconectando a SignalR: $e");
        return;
      }
    }

    final command = {
      "EmpleoyeeID": employeeID,
      "TravelID": travelID,
      "TravelSpeed": travelSpeed,
      "Coordinate": {"Lat": latitude, "Lng": longitude},
      "ConnectionID": connectionID,
    };

    try {
      await _hubConnection.invoke("UpdateTravelPosition", args: [command]);
      print("Travel position updated successfully");
    } catch (error) {
      print("Error updating travel position: $error");
    }
  }
}
