part of 'flight_bloc.dart';

@immutable
abstract class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object?> get props => [];
}

class FlightLoading extends FlightState {}

class FlightLoaded extends FlightState {
  final List<FlightModel> flights;
  final List<FlightModel> flightsFilter;

  const FlightLoaded({this.flights = const [], this.flightsFilter = const []});

  @override
  List<Object?> get props => [flights, flightsFilter];
}
