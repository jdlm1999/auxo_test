class ItineraryModel {
  ItineraryModel({
    required this.id,
    required this.legs_1,
    required this.legs_2,
    required this.price,
    required this.agent,
    required this.agentRating,
  });

  String id;
  String legs_1;
  String legs_2;
  String price;
  String agent;
  double agentRating;

  factory ItineraryModel.fromJson(Map<String, dynamic> json) => ItineraryModel(
        id: json["id"],
        legs_1: json["legs"][0],
        legs_2: json["legs"][1],
        price: json["price"],
        agent: json["agent"],
        agentRating: json["agent_rating"].toDouble(),
      );

  factory ItineraryModel.fromSqlite(Map<String, dynamic> json) =>
      ItineraryModel(
        id: json["id"],
        legs_1: json["legs1"],
        legs_2: json["legs2"],
        price: json["price"],
        agent: json["agent"],
        agentRating: json["agentRating"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "legs1": legs_1,
        "legs2": legs_2,
        "price": price,
        "agent": agent,
        "agentRating": agentRating,
      };
}
