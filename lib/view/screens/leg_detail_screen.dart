import 'package:auxo_test/models/flight_model.dart';
import 'package:auxo_test/view/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class LegDetail extends StatelessWidget {
  static const String routeName = '/leg_detail';
  static Route route({required FlightModel flight}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => LegDetail(flight: flight),
    );
  }

  final FlightModel flight;

  const LegDetail({Key? key, required this.flight}) : super(key: key);

  leg_container() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(flight.leg1.airlineName,
                      style: TextStyle(fontSize: 18.0)),
                  Text(flight.leg1.departureTime,
                      style: TextStyle(fontSize: 12.0)),
                  Text(flight.leg1.departureAirport,
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
              Column(
                children: [
                  Text('${flight.leg2.airlineName}',
                      style: TextStyle(fontSize: 18.0)),
                  Text('${flight.leg2.arrivalTime}',
                      style: TextStyle(fontSize: 12.0)),
                  Text('${flight.leg2.arrivalAirport}',
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leg Detail'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 120.0,
              width: 220.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://englishlive.ef.com/es-es/blog/wp-content/uploads/sites/12/2018/05/travel-phrasal-verbs.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('AGENT:', style: TextStyle(fontSize: 18.0)),
                  Text(flight.itinerary.agent,
                      style: const TextStyle(fontSize: 25.0)),
                ],
              ),
            ),
            leg_container(),
          ],
        ),
      ),
    );
  }
}
