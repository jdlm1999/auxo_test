import 'package:auxo_test/models/flight_model.dart';
import 'package:flutter/material.dart';

class FlightCard extends StatefulWidget {
  final FlightModel? flight;
  const FlightCard({Key? key, this.flight}) : super(key: key);

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/leg_detail', arguments: widget.flight),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(6.0, 6.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Angent: ${widget.flight!.itinerary.agent}'),
                ),
                Expanded(
                  child: Text(
                      'Price: ${widget.flight!.itinerary.price.toString()}'),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Leg_1: ${widget.flight!.leg1.airlineName}'),
                ),
                Expanded(
                  child: Text('Leg_2: ${widget.flight!.leg2.airlineName}'),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text('Rating: ${widget.flight!.itinerary.agentRating}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
