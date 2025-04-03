import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRService with ChangeNotifier {
  late final HubConnection _hubConnection;
  final List<String> _messages = [];
  List<String> get messages => _messages;

  // Constructor: Recibe la URL de conexión a tu Hub
  SignalRService({required String serverUrl}) {
    _hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  // Inicia la conexión y registra los handlers para los métodos del servidor
  Future<void> startConnection() async {
    print("Iniciando conexión a SignalR...");
    try {
      _hubConnection.onclose((error) {
        if (error != null) {
          print("Conexión cerrada con error: $error");
        } else {
          print("Conexión cerrada.");
        }
      });

      // Handler para recibir errores enviados desde el servidor
      _hubConnection.on("Error", (arguments) {
        final errorMessage = arguments?[0];
        print("Error recibido del servidor: $errorMessage");
      });

      // Handler para mensajes de chat (ejemplo)
      _hubConnection.on("ReceiveMessage", (arguments) {
        final user = arguments?[0] as String;
        final message = arguments?[1] as String;
        _messages.add("$user: $message");
        notifyListeners();
      });

      // Handler para recibir notificaciones de cambios en el viaje desde el backend
      _hubConnection.on("ReceiveTravelNotification", (arguments) {
        final travelData = arguments?[0];
        // Agrega el mensaje a la lista de mensajes, formateándolo para identificarlo como notificación
        _messages.add("Travel Notification: ${travelData.toString()}");
        notifyListeners();
      });

      await _hubConnection.start();
      print("Conexión iniciada correctamente");
    } catch (e) {
      print("Error iniciando la conexión: $e");
    }
  }

  // Método para enviar un mensaje de chat (ejemplo genérico)
  Future<void> sendMessage(String user, String message) async {
    try {
      await _hubConnection.invoke("SendMessage", args: [user, message]);
      _messages.add("Tú: $message");
      notifyListeners();
    } catch (e) {
      print("Error enviando mensaje: $e");
    }
  }

  // Método que espera a que la conexión esté en estado "connected"
  Future<void> _waitForConnection() async {
    while (_hubConnection.state != HubConnectionState.connected) {
      print("Esperando conexión... Estado actual: ${_hubConnection.state}");
      await Future.delayed(Duration(milliseconds: 500));
      if (_hubConnection.state == HubConnectionState.disconnected) {
        try {
          print("Intentando reconectar...");
          await _hubConnection.start();
        } catch (e) {
          print("Error iniciando reconexión: $e");
        }
      }
    }
  }

  /// Método para crear una reserva (invoca el comando CreateReser en el hub)
  Future<void> createReservation({
    required int travelID,
    required int customerID,
    required int entryStep,
    required int seatsQuantity,
    required String paymentType,
  }) async {
    try {
      if (_hubConnection.state != HubConnectionState.connected) {
        print(
          "La conexión no está lista (estado: ${_hubConnection.state}). Esperando...",
        );
        await _waitForConnection();
      }

      final command = {
        "TravelID": travelID,
        "CustomerID": customerID,
        "EntryStep": entryStep,
        "SeatsQuantity": seatsQuantity,
        "PaymentType": paymentType,
      };
      await _hubConnection.invoke("CreateReser", args: [command]);
      print("Comando CreateReser enviado correctamente");
    } catch (e) {
      print("Error enviando comando CreateReser: $e");
    }
  }

  /// Método para confirmar una cuota (invoca el comando ConfirmQuota en el hub)
  Future<void> confirmQuota({
    required String quotaID,
    required String travelID,
  }) async {
    try {
      if (_hubConnection.state != HubConnectionState.connected) {
        print(
          "La conexión no está lista (estado: ${_hubConnection.state}). Esperando...",
        );
        await _waitForConnection();
      }

      final command = {"QuotaID": quotaID, "TravelID": travelID};
      await _hubConnection.invoke("ConfirmQuota", args: [command]);
      print("Comando ConfirmQuota enviado correctamente");
    } catch (e) {
      print("Error enviando comando ConfirmQuota: $e");
    }
  }

  /// Método para suscribir al cliente a actualizaciones de un viaje
  Future<void> suscribeToTravel(int travelId) async {
    try {
      if (_hubConnection.state != HubConnectionState.connected) {
        print("La conexión no está lista, esperando...");
        await _waitForConnection();
      }
      await _hubConnection.invoke("SuscribeToTravel", args: [travelId]);
      print("Comando SuscribeToTravel enviado correctamente");
    } catch (e) {
      print("Error enviando comando SuscribeToTravel: $e");
    }
  }

  // Detiene la conexión con el hub
  Future<void> stopConnection() async {
    await _hubConnection.stop();
  }
}
