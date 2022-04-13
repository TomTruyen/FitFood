import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/services/Converters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  Database db;
  List<Nutrition> nutrition = [];
  Nutrition todayNutrition = new Nutrition();

  Future<String> getPersistentDBPath() async {
    try {
      if (await Permission.storage.request().isGranted) {
        String externalDirectoryPath =
            await ExtStorage.getExternalStorageDirectory();
        String directoryPath = "$externalDirectoryPath/fitfood_persistent";
        await (new Directory(directoryPath).create());
        return "$directoryPath/fitfood.db";
      }

      return null;
    } catch (e) {
      print("Error getting PersistentPath: $e");
      return null;
    }
  }

  Future<void> setupDatabase() async {
    try {
      String path = await getPersistentDBPath();

      if (path == null) {
        String databasePath = await getDatabasesPath();
        path = databasePath + 'fitfood.db';
      }

      // Date is as INTEGER (millisSinceEpoch)
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE nutrition (date TEXT PRIMARY KEY UNIQUE, kcal INTEGER, carbs INTEGER, protein INTEGER, fat INTEGER)',
            [],
          );
        },
      );
    } catch (e) {
      print("Setup Database Error $e");
    }
  }

  Future<void> refreshNutrition() async {
    await getNutrition();
    await getTodayNutrition();
  }

  Future<void> getNutrition() async {
    try {
      List<Map> _nutrition =
          await db.rawQuery('SELECT * FROM nutrition ORDER BY date DESC');

      nutrition = convertToNutritionList(_nutrition) ?? [];
    } catch (e) {
      print("Get Nutrition Error: $e");
    }
  }

  Future<void> getTodayNutrition() async {
    try {
      DateTime now = DateTime.now();
      String today =
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      List<Map> _todayNutrition = await db.rawQuery(
        'SELECT * FROM nutrition WHERE date = ?',
        [today],
      );

      todayNutrition = convertToNutrition(_todayNutrition);
    } catch (e) {
      print("Get TodayNutrition Error $e");
    }
  }

  Future<bool> overrideNutrition(Nutrition nutrition) async {
    try {
      await db.rawUpdate(
        'UPDATE nutrition SET kcal = ?, carbs = ?, protein = ?, fat = ? WHERE date = ?',
        [
          nutrition.kcal,
          nutrition.carbs,
          nutrition.protein,
          nutrition.fat,
          nutrition.time
        ],
      );

      await getNutrition();
      await getTodayNutrition();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addNutrition(Nutrition _nutrition) async {
    try {
      Nutrition foundNutrition;

      if (nutrition != null && nutrition.length > 0) {
        nutrition.forEach((n) {
          if (n.time == _nutrition.time) {
            foundNutrition = n;
          }
        });
      }

      if (foundNutrition == null) {
        await db.rawInsert(
          'INSERT INTO nutrition (date, kcal, carbs, protein, fat) VALUES (?, ?, ?, ?, ?)',
          [
            _nutrition.time,
            _nutrition.kcal,
            _nutrition.carbs,
            _nutrition.protein,
            _nutrition.fat
          ],
        );
      } else {
        foundNutrition.kcal += _nutrition.kcal;
        foundNutrition.carbs += _nutrition.carbs;
        foundNutrition.protein += _nutrition.protein;
        foundNutrition.fat += _nutrition.fat;

        await db.rawUpdate(
          'UPDATE nutrition SET kcal = ?, carbs = ?, protein = ?, fat = ? WHERE date = ?',
          [
            foundNutrition.kcal,
            foundNutrition.carbs,
            foundNutrition.protein,
            foundNutrition.fat,
            foundNutrition.time
          ],
        );
      }

      await getNutrition();
      await getTodayNutrition();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNutrition(String date) async {
    try {
      await db.rawDelete(
        'DELETE FROM nutrition WHERE date = ?',
        [date],
      );

      await getNutrition();
      await getTodayNutrition();

      return true;
    } catch (e) {
      return false;
    }
  }
}
