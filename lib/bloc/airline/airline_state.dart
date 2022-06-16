part of 'airline_bloc.dart';

@immutable
abstract class AirlineState extends Equatable {
  const AirlineState();

  @override
  List<Object?> get props => [];
}

class AirlineLoading extends AirlineState {}

class AirlinesLoaded extends AirlineState {
  final List<AirlineModel> airlines;
  final List<AirlineModel> airlinesFilter;

  const AirlinesLoaded(
      {this.airlines = const [], this.airlinesFilter = const []});

  @override
  List<Object?> get props => [airlines, airlinesFilter];
}
