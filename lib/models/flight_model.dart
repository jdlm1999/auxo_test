import 'package:auxo_test/models/itinerarie_model.dart';
import 'package:auxo_test/models/leg_model.dart';

class FlightModel {
  ItineraryModel itinerary;
  LegModel leg1;
  LegModel leg2;

  FlightModel({
    required this.itinerary,
    required this.leg1,
    required this.leg2,
  });
}
