class Coordinate {
  final double lat;
  final double lng;

  Coordinate({
    required this.lat,
    required this.lng,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}

class TravelLocationChangeNotification {
  final String travelID;
  final Coordinate actualLocation;
  final int nextStep;
  final String stepState;
  final Coordinate waypointLocation;
  final String tiempoEstimado;

  TravelLocationChangeNotification({
    required this.travelID,
    required this.actualLocation,
    required this.nextStep,
    required this.stepState,
    required this.waypointLocation,
    required this.tiempoEstimado,
  });

  factory TravelLocationChangeNotification.fromJson(Map<String, dynamic> json) {
    return TravelLocationChangeNotification(
      travelID: json['travelID'] as String,
      actualLocation: Coordinate.fromJson(json['actualLocation']),
      nextStep: json['nextStep'] as int,
      stepState: json['stepState'] as String,
      waypointLocation: Coordinate.fromJson(json['waypointLocation']),
      tiempoEstimado: json['tiempoEstimado'] as String,
    );
  }
}
