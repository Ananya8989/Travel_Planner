import 'dart:developer' as developer;
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:travel_app/myTrips.dart';
import 'package:travel_app/trip.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final DatabaseHelper dH = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return dH;
  }
  Future<void> initDB() async {
   
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'trip.db'),
      onCreate: (database, version) async {
        await database.execute(
            """
            CREATE TABLE trips (
              name TEXT NOT NULL,
              type TEXT NOT NULL,
              delete INTEGER NOT NULL, 
            )
          """,
        );
      },
      version: 1,
    );
  }


  Future<int> setTrip(Trip trip) async {
    int result = await db.insert('trips', trip.toMap());
    return result;
  }
 
  Future<List<Trip>> getTrip() async {
    final List<Map<String, Object?>> queryResult = await db.query('trips');
    return queryResult.map((e) => Trip.fromMap(e)).toList();
  }


  Future<void> deleteTrip(String name) async {
    await db.delete(
      'trips',
      where: "name = ?",
      whereArgs: [name],
    );
  }
 
}


