import 'package:auxo_test/bloc/airline/airline_bloc.dart';
import 'package:auxo_test/bloc/flight/flight_bloc.dart';
import 'package:auxo_test/bloc_observer.dart';
import 'package:auxo_test/config/app_router.dart';
import 'package:auxo_test/repositories/data_fetch_repository.dart';
import 'package:auxo_test/view/screens/main_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FlightBloc>(
          create: (context) => FlightBloc(
            dataFetchRepository: DataFetchRepository(),
          )..add(LoadFlights()),
        ),
        BlocProvider<AirlineBloc>(
          create: (context) => AirlineBloc()..add(LoadAirline()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MainPageScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: MainPageScreen.routeName,
      ),
    );
  }
}
