class Nutrition {
  int kcal;
  int carbs;
  int protein;
  int fat;
  String time;

  Nutrition({
    this.kcal = 0,
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
    this.time,
  }) {
    if (this.time == null) {
      DateTime now = DateTime.now();
      String today =
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
      this.time = today;
    }
  }

  Map<String, dynamic> toJson() {
    if (this.time.length < 10) {
      List<String> timeSplitted = this.time.split('-');
      String day = timeSplitted[0].padLeft(2, '0');
      String month = timeSplitted[1].padLeft(2, '0');
      String year = timeSplitted[2];

      this.time = "$day-$month-$year";
    }

    return {
      "kcal": kcal,
      "carbs": carbs,
      "protein": protein,
      "fat": fat,
      "time": time,
    };
  }
}
