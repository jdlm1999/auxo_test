class AirlineModel {
  String id;
  String airlineName;
  String airlineId;
  int countLegs;

  AirlineModel({
    required this.id,
    required this.airlineName,
    required this.airlineId,
    required this.countLegs,
  });

  factory AirlineModel.fromSqlite(Map<String, dynamic> json) => AirlineModel(
        id: json["id"],
        airlineName: json["airlineName"],
        airlineId: json["airlineId"],
        countLegs: json["COUNT(*)"],
      );
}
