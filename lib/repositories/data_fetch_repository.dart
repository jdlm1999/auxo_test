import 'dart:convert';

import 'package:auxo_test/models/itinerarie_model.dart';
import 'package:auxo_test/models/leg_model.dart';
import 'package:auxo_test/repositories/data_base_helper.dart';
import 'package:http/http.dart' as http;

class DataFetchRepository {
  final String url =
      'https://raw.githubusercontent.com/Skyscanner/full-stack-recruitment-test/main/public/flights.json';

  Future getAll<T>() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      var i = 0;
      while (i < json['legs'].length) {
        await DataBaseHelper.instance
            .addLeg(LegModel.fromJson(json['legs'][i]));
        i++;
      }
      i = 0;
      while (i < json['itineraries'].length) {
        await DataBaseHelper.instance
            .addItinerary(ItineraryModel.fromJson(json['itineraries'][i]));
        i++;
      }
    } else {
      throw Exception('Failed to load album');
    }
  }
}
