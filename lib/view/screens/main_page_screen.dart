import 'package:auxo_test/bloc/flight/flight_bloc.dart';
import 'package:auxo_test/view/widgets/bottom_navigation_bar.dart';
import 'package:auxo_test/view/widgets/fligh_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageScreen extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MainPageScreen(),
    );
  }

  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  String dropdownValue = 'Filter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Auxo Test')),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Filter', 'Price', 'Rating', 'Agent']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    onChanged: ((value) =>
                        BlocProvider.of<FlightBloc>(context, listen: false).add(
                          FilterFlights(dropdownValue, value),
                        )),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none),
                      hintText: "Search...",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<FlightBloc, FlightState>(builder: ((context, state) {
            if (state is FlightLoaded) {
              if (state.flightsFilter.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.flightsFilter.length,
                    itemBuilder: (context, index) {
                      return FlightCard(
                        flight: state.flightsFilter[index],
                      );
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.flights.length,
                    itemBuilder: (context, index) {
                      return FlightCard(
                        flight: state.flights[index],
                      );
                    },
                  ),
                );
              }
            }
            return Text('BlocBuilder: ${state.toString()}');
          }))
        ],
      ),
    );
  }
}
