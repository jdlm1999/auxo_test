import 'package:auxo_test/bloc/airline/airline_bloc.dart';
import 'package:auxo_test/view/widgets/air_card.dart';
import 'package:auxo_test/view/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirlineScreen extends StatefulWidget {
  static const String routeName = '/air';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const AirlineScreen(),
    );
  }

  const AirlineScreen({Key? key}) : super(key: key);

  @override
  State<AirlineScreen> createState() => _AirlineScreenState();
}

class _AirlineScreenState extends State<AirlineScreen> {
  String dropdownValue = 'Filter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Auxo Test')),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
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
                    items: <String>['Filter', 'Airline']
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
                        BlocProvider.of<AirlineBloc>(context, listen: false)
                            .add(
                          FilterAirlines(dropdownValue, value),
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
          BlocBuilder<AirlineBloc, AirlineState>(builder: ((context, state) {
            if (state is AirlinesLoaded) {
              if (state.airlinesFilter.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.airlinesFilter.length,
                      itemBuilder: (context, index) {
                        return AirlineCard(
                          airline: state.airlinesFilter[index],
                        );
                      }),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.airlines.length,
                      itemBuilder: (context, index) {
                        return AirlineCard(
                          airline: state.airlines[index],
                        );
                      }),
                );
              }
            }
            return Text('BlocBuilder: ${state.toString()}');
          })),
        ],
      ),
    );
  }
}
