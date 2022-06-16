import 'package:auxo_test/models/ariline_model.dart';
import 'package:flutter/material.dart';

class AirlineCard extends StatefulWidget {
  final AirlineModel? airline;
  const AirlineCard({Key? key, this.airline}) : super(key: key);

  @override
  State<AirlineCard> createState() => _AirlineCardState();
}

class _AirlineCardState extends State<AirlineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text('Angent: ${widget.airline!.airlineName}'),
          Text('Count Legs: ${widget.airline!.countLegs}'),
        ],
      ),
    );
  }
}
