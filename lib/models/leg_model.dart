class LegModel {
  LegModel({
    required this.id,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.stops,
    required this.airlineName,
    required this.airlineId,
    required this.durationMins,
  });

  String id;
  String departureAirport;
  String arrivalAirport;
  String departureTime;
  String arrivalTime;
  int stops;
  String airlineName;
  String airlineId;
  int durationMins;

  factory LegModel.fromJson(Map<String, dynamic> json) => LegModel(
        id: json["id"],
        departureAirport: json["departure_airport"],
        arrivalAirport: json["arrival_airport"],
        departureTime: json["departure_time"],
        arrivalTime: json["arrival_time"],
        stops: json["stops"],
        airlineName: json["airline_name"],
        airlineId: json["airline_id"],
        durationMins: json["duration_mins"],
      );

  factory LegModel.fromSqlite(Map<String, dynamic> json) => LegModel(
        id: json["id"],
        departureAirport: json["departureAirport"],
        arrivalAirport: json["arrivalAirport"],
        departureTime: json["departureTime"],
        arrivalTime: json["arrivalTime"],
        stops: json["stops"],
        airlineName: json["airlineName"],
        airlineId: json["airlineId"],
        durationMins: json["durationMins"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "departureAirport": departureAirport,
        "arrivalAirport": arrivalAirport,
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "stops": stops,
        "airlineName": airlineName,
        "airlineId": airlineId,
        "durationMins": durationMins,
      };
}
