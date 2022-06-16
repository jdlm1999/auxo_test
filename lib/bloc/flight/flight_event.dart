part of 'flight_bloc.dart';

@immutable
abstract class FlightEvent extends Equatable {
  const FlightEvent();

  @override
  List<Object?> get props => [];
}

class LoadFlights extends FlightEvent {}

class UpdateFlights extends FlightEvent {
  final List<LegModel> legs;
  final List<ItineraryModel> itineraries;

  const UpdateFlights(this.legs, this.itineraries);

  @override
  List<Object?> get props => [legs, itineraries];
}

class FilterFlights extends FlightEvent {
  final String filter;
  final String text;

  const FilterFlights(this.filter, this.text);

  @override
  List<Object?> get props => [filter, text];
}
