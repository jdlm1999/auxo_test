import 'dart:async';

import 'package:auxo_test/models/ariline_model.dart';
import 'package:auxo_test/models/flight_model.dart';
import 'package:auxo_test/models/itinerarie_model.dart';
import 'package:auxo_test/models/leg_model.dart';
import 'package:auxo_test/repositories/data_base_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'airline_event.dart';
part 'airline_state.dart';

class AirlineBloc extends Bloc<AirlineEvent, AirlineState> {
  StreamSubscription? _productSubscription;
  AirlineBloc() : super(AirlineLoading()) {
    on<LoadAirline>(_onLoadAirline);
    on<FilterAirlines>(_onFilterAirlines);
  }

  void _onLoadAirline(AirlineEvent event, Emitter<AirlineState> emit) async {
    final sqliteResponse = await DataBaseHelper.instance.getAirlines();
    emit(AirlinesLoaded(airlines: sqliteResponse));
  }

  void _onFilterAirlines(FilterAirlines event, Emitter<AirlineState> emit) {
    List<AirlineModel> airlines = [];

    switch (event.filter) {
      case 'Airline':
        airlines = (state.props[0] as List<AirlineModel>)
            .where((element) => element.airlineName
                .toLowerCase()
                .contains(event.text.toLowerCase()))
            .toList();
        break;
      default:
    }

    emit(AirlinesLoaded(
        airlines: (state.props[0] as List<AirlineModel>),
        airlinesFilter: airlines));
  }
}
