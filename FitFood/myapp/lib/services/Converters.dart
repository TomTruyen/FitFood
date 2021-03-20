import 'package:myapp/models/Nutrition.dart';

List<Nutrition> convertToNutritionList(List<Map> nutrition) {
  List<Nutrition> nutritionList = [];

  if (nutrition != null && nutrition.length > 0) {
    nutrition.forEach((_nutrition) {
      nutritionList.add(
        Nutrition(
          time: _nutrition['date'],
          kcal: _nutrition['kcal'],
          carbs: _nutrition['carbs'],
          protein: _nutrition['protein'],
          fat: _nutrition['fat'],
        ),
      );
    });
  }

  return nutritionList;
}

Nutrition convertToNutrition(List<Map> nutrition) {
  if (nutrition == null || nutrition.length == 0) {
    return Nutrition();
  }

  String date = nutrition[0]['date'];

  int kcal = 0;
  int carbs = 0;
  int protein = 0;
  int fat = 0;

  nutrition.forEach((_nutrition) {
    kcal += _nutrition['kcal'];
    carbs += _nutrition['carbs'];
    protein += _nutrition['protein'];
    fat += _nutrition['fat'];
  });

  return Nutrition(
    time: date,
    kcal: kcal,
    carbs: carbs,
    protein: protein,
    fat: fat,
  );
}
