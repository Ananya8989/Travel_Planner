import 'dart:async';
import 'package:travel_app/dests.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
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
      join(path, 'task.db'),
      onCreate: (database, version) async {
        await database.execute(
            """
            CREATE TABLE dest (
              done INTEGER NOT NULL,
              name TEXT NOT NULL,
              pos INTEGER NOT NULL
            )
          """,
        );
        await database.execute(
            """
            CREATE TABLE tasks (
              done INTEGER NOT NULL,
              name TEXT NOT NULL,
              type TEXT NOT NULL
            )
          """,
        );
         
      },
      version: 1,
    );
   
  }


  Future<int> setTrip(Trip trip) async {
    int result = await db.insert('tasks', trip.toMap());
    return result;
  }
 
  Future<List<Trip>> getTrip() async {
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    return queryResult.map((e) => Trip.fromMap(e)).toList();
  }


  Future<void> deleteTrip(String name) async {
    await db.delete(
      'tasks',
      where: "name = ?",
      whereArgs: [name],
    );
  }
 
  Future<int> setDest(Dests dest) async {
    int result = await db.insert('dest', dest.toMap());
    return result;
  }

 
  Future<List<Dests>> getDest() async {
    final List<Map<String, Object?>> queryResult = await db.query('dest');
    return queryResult.map((e) => Dests.fromMap(e)).toList();
  }

  Future<void>updateDest(String name, String newName)async{
    
  }
  Future<void> deleteDest(String name) async {
    await db.delete(
      'dest',
      where: "name = ?",
      whereArgs: [name],
    );
  }
}







