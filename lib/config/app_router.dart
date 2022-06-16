import 'package:auxo_test/models/flight_model.dart';
import 'package:auxo_test/view/screens/air_screen.dart';
import 'package:auxo_test/view/screens/leg_detail_screen.dart';
import 'package:auxo_test/view/screens/main_page_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MainPageScreen.route();
      case '/air':
        return AirlineScreen.route();
      case '/leg_detail':
        return LegDetail.route(flight: settings.arguments as FlightModel);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        body: Center(
          child: AppBar(title: const Text('Error')),
        ),
      ),
    );
  }
}
