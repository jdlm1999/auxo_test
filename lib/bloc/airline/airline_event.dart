part of 'airline_bloc.dart';

@immutable
abstract class AirlineEvent extends Equatable {
  const AirlineEvent();

  @override
  List<Object?> get props => [];
}

class LoadAirline extends AirlineEvent {}

class UpdateAirlline extends AirlineEvent {
  final List<LegModel> legs;

  const UpdateAirlline(this.legs);

  @override
  List<Object?> get props => [legs];
}

class FilterAirlines extends AirlineEvent {
  final String filter;
  final String text;

  const FilterAirlines(this.filter, this.text);

  @override
  List<Object?> get props => [filter, text];
}
