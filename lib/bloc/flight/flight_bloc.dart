import 'dart:async';

import 'package:auxo_test/models/flight_model.dart';
import 'package:auxo_test/models/itinerarie_model.dart';
import 'package:auxo_test/models/leg_model.dart';
import 'package:auxo_test/repositories/data_base_helper.dart';
import 'package:auxo_test/repositories/data_fetch_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'flight_event.dart';
part 'flight_state.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final DataFetchRepository _dataFetchRepository;
  StreamSubscription? _productSubscription;

  FlightBloc({required DataFetchRepository dataFetchRepository})
      : _dataFetchRepository = dataFetchRepository,
        super(FlightLoading()) {
    on<LoadFlights>(_onLoadFlights);
    on<FilterFlights>(_onFilterFlights);
  }

  void _onLoadFlights(LoadFlights event, Emitter<FlightState> emit) async {
    _productSubscription?.cancel();
    await _dataFetchRepository.getAll();
    final sqliteResponse = await DataBaseHelper.instance.getLegs();
    final sqliteResponse2 = await DataBaseHelper.instance.getItineraries();
    List<FlightModel> flights = [];
    for (var i = 0; i < sqliteResponse2.length; i++) {
      List<LegModel> leg_1 = await DataBaseHelper.instance
          .getLegsbyItinierary(sqliteResponse2[i].legs_1);
      List<LegModel> leg_2 = await DataBaseHelper.instance
          .getLegsbyItinierary(sqliteResponse2[i].legs_2);
      ItineraryModel itinerary = sqliteResponse2[i];
      FlightModel flightModel = FlightModel(
        itinerary: itinerary,
        leg1: leg_1[0],
        leg2: leg_2[0],
      );
      flights.add(flightModel);
    }
    emit(FlightLoaded(flights: flights));
  }

  void _onFilterFlights(FilterFlights event, Emitter<FlightState> emit) async {
    List<FlightModel> flights = [];
    switch (event.filter) {
      case 'Agent':
        flights = (state.props[0] as List<FlightModel>)
            .where((element) => element.itinerary.agent
                .toLowerCase()
                .contains(event.text.toLowerCase()))
            .toList();
        break;
      case 'Price':
        flights = (state.props[0] as List<FlightModel>)
            .where((element) => element.itinerary.price
                .toString()
                .toLowerCase()
                .contains(event.text.toLowerCase()))
            .toList();
        break;
      case 'Rating':
        flights = (state.props[0] as List<FlightModel>)
            .where((element) => element.itinerary.agentRating
                .toString()
                .toLowerCase()
                .contains(event.text.toLowerCase()))
            .toList();
        break;
      default:
    }
    emit(FlightLoaded(
        flights: (state.props[0] as List<FlightModel>),
        flightsFilter: flights));
  }
}
