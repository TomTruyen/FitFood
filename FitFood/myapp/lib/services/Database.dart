import 'package:myapp/services/Converters.dart';
import 'package:sqflite/sqflite.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/shared/Globals.dart' as globals;
// import 'package:myapp/database_service.dart';

Future<Database> setupDatabase() async {
  try {
    String databasePath = await getDatabasesPath();
    String path = databasePath + 'fitfood.db';

    // Date is as INTEGER (millisSinceEpoch)
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE nutrition (date TEXT PRIMARY KEY UNIQUE, kcal INTEGER, carbs INTEGER, protein INTEGER, fat INTEGER)',
          [],
        );
      },
    );

    return db;
  } catch (e) {
    return null;
  }
}

Future<List<Nutrition>> getNutrition() async {
  try {
    if (globals.db == null) {
      return null;
    }

    List<Map> nutrition =
        await globals.db.rawQuery('SELECT * FROM nutrition ORDER BY date DESC');

    return convertToNutritionList(nutrition);
  } catch (e) {
    return null;
  }
}

Future<Nutrition> getTodayNutrition() async {
  try {
    if (globals.db == null) {
      return null;
    }

    DateTime now = DateTime.now();
    String today =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    List<Map> todayNutrition = await globals.db.rawQuery(
      'SELECT * FROM nutrition WHERE date = ?',
      [today],
    );

    return convertToNutrition(todayNutrition);
  } catch (e) {
    return null;
  }
}

Future<bool> addNutrition(Nutrition nutrition) async {
  try {
    if (globals.db == null) {
      return false;
    }

    Nutrition foundNutrition;

    if (globals.nutrition != null && globals.nutrition.length > 0) {
      globals.nutrition.forEach((_nutrition) {
        if (_nutrition.time == nutrition.time) {
          foundNutrition = _nutrition;
        }
      });
    }

    if (foundNutrition == null) {
      await globals.db.rawInsert(
        'INSERT INTO nutrition (date, kcal, carbs, protein, fat) VALUES (?, ?, ?, ?, ?)',
        [
          nutrition.time,
          nutrition.kcal,
          nutrition.carbs,
          nutrition.protein,
          nutrition.fat
        ],
      );
    } else {
      foundNutrition.kcal += nutrition.kcal;
      foundNutrition.carbs += nutrition.carbs;
      foundNutrition.protein += nutrition.protein;
      foundNutrition.fat += nutrition.fat;

      await globals.db.rawUpdate(
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

    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> deleteNutrition(String date) async {
  try {
    if (globals.db == null) {
      return false;
    }

    await globals.db.rawDelete(
      'DELETE FROM nutrition WHERE date = ?',
      [date],
    );

    return true;
  } catch (e) {
    return false;
  }
}
