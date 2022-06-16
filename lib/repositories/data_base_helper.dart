import 'dart:io';
import 'package:auxo_test/models/ariline_model.dart';
import 'package:auxo_test/models/itinerarie_model.dart';
import 'package:auxo_test/models/leg_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'flights.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE legs (
          id TEXT PRIMARY KEY,
          departureAirport TEXT,
          arrivalAirport TEXT,
          departureTime TEXT,
          arrivalTime TEXT,
          stops INTEGER,
          airlineName TEXT,
          airlineId TEXT,
          durationMins INTEGER
        );
      ''');

    await db.execute('''
        CREATE TABLE itineraries (
          id TEXT PRIMARY KEY,
          legs1 TEXT,
          legs2 TEXT,
          price TEXT,
          agent TEXT,
          agentRating DOUBLE
        );
      ''');
  }

  Future<int> addLeg(LegModel legs) async {
    try {
      final Database db = await database;
      LegModel? value = await getLegById(legs.id);
      if (value == null) {
        return db.insert('legs', legs.toMap());
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception('ADD Leg error ${e.toString()}');
    }
  }

  Future<int> addItinerary(ItineraryModel itinerary) async {
    try {
      final Database db = await database;
      ItineraryModel? value = await getItinerarieById(itinerary.id);
      if (value == null) {
        return db.insert('itineraries', itinerary.toMap());
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception('ADD Leg error ${e.toString()}');
    }
  }

  Future<List<LegModel>> getLegs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('legs');
    List<LegModel> legs = maps.isNotEmpty
        ? maps.map((leg) => LegModel.fromSqlite(leg)).toList()
        : [];
    return legs;
  }

  Future<List<ItineraryModel>> getItineraries() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('itineraries');
    List<ItineraryModel> itineraries = maps.isNotEmpty
        ? maps.map((itinerary) => ItineraryModel.fromSqlite(itinerary)).toList()
        : [];

    return itineraries;
  }

  Future<List<LegModel>> getLegsbyItinierary(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('legs', where: 'id = ?', whereArgs: [id]);
    List<LegModel> legs = maps.isNotEmpty
        ? maps.map((leg) => LegModel.fromSqlite(leg)).toList()
        : [];
    return legs;
  }

  Future<LegModel?> getLegById(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('legs', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return LegModel.fromSqlite(maps.first);
    }
    return null;
  }

  Future<List<AirlineModel>> getAirlines() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT *, COUNT(*) FROM legs GROUP BY airlineName');
    List<AirlineModel> list = maps.isNotEmpty
        ? maps.map((leg) => AirlineModel.fromSqlite(leg)).toList()
        : [];
    return list;
  }

  Future<ItineraryModel?> getItinerarieById(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('itineraries', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ItineraryModel.fromSqlite(maps.first);
    }
    return null;
  }
}
