import 'package:flutter/material.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/shared/AddNutritionCard.dart';
import 'package:myapp/shared/Functions.dart';
import 'package:myapp/shared/Globals.dart' as globals;
import 'package:myapp/shared/Loading.dart';

class KcalTrackerAdder extends StatelessWidget {
  final List<Nutrition> nutrition;
  final Nutrition todayNutrition;
  final Function refreshNutrition;

  KcalTrackerAdder({
    this.nutrition,
    this.todayNutrition,
    this.refreshNutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrition Adder',
        ),
      ),
      body: MyStateWidget(
        nutrition: nutrition,
        todayNutrition: todayNutrition,
        refreshNutrition: refreshNutrition,
      ),
    );
  }
}

class MyStateWidget extends StatefulWidget {
  final List<Nutrition> nutrition;
  final Nutrition todayNutrition;
  final Function refreshNutrition;

  MyStateWidget({
    this.nutrition,
    this.todayNutrition,
    this.refreshNutrition,
  });

  @override
  KcalTrackerBody createState() => KcalTrackerBody();
}

class KcalTrackerBody extends State<MyStateWidget> {
  final kcalController = TextEditingController();
  final carbsController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();

  @override
  initState() {
    if (mounted) {
      setState(() {
        kcalController.text = "1250";
        carbsController.text = "100";
        proteinController.text = "50";
        fatController.text = "50";
      });
    }

    super.initState();
  }

  int getIntValue(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext build) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    int kcal = getIntValue(kcalController.text);
    int carbs = getIntValue(carbsController.text);
    int protein = getIntValue(proteinController.text);
    int fat = getIntValue(fatController.text);

    void _showSaveDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              constraints: BoxConstraints(
                minHeight: 150.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xFF1d1e33),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: 150.0,
                    child: Loading(text: 'Saving...'),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: AddNutritionCard(
                text: 'CALORIES',
                value: kcal,
                maxValue: 2500,
                controller: kcalController,
                textHeightUnit: unitHeightValue,
                onChanged: (String value) {
                  setState(() {
                    kcalController.value = kcalController.value.copyWith(
                      text: value,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: AddNutritionCard(
                text: 'CARBS',
                value: carbs,
                maxValue: 200,
                controller: carbsController,
                textHeightUnit: unitHeightValue,
                onChanged: (String value) {
                  setState(() {
                    carbsController.value = carbsController.value.copyWith(
                      text: value,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: AddNutritionCard(
                text: 'PROTEIN',
                value: protein,
                maxValue: 100,
                controller: proteinController,
                textHeightUnit: unitHeightValue,
                onChanged: (String value) {
                  setState(() {
                    proteinController.value = proteinController.value.copyWith(
                      text: value,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: AddNutritionCard(
                text: 'FAT',
                value: fat,
                maxValue: 100,
                controller: fatController,
                textHeightUnit: unitHeightValue,
                onChanged: (String value) {
                  setState(() {
                    fatController.value = fatController.value.copyWith(
                      text: value,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    );
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                _showSaveDialog();

                Nutrition nutrition = Nutrition(
                  kcal: kcal,
                  carbs: carbs,
                  protein: protein,
                  fat: fat,
                  time: globals.sqlDatabase.todayNutrition.time,
                );

                // ADD NUTRITION TO DATABASE
                bool isSaved =
                    await globals.sqlDatabase.addNutrition(nutrition);

                bool isRefreshed = await widget.refreshNutrition();

                if (isSaved && isRefreshed) {
                  tryPopContext(context);
                  tryPopContext(context);
                }
              },
              child: Container(
                child: Center(
                  child: Text('CONFIRM',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: unitHeightValue * 25.0)),
                ),
                height: 80.0,
                margin: EdgeInsets.only(top: 10.0),
                color: Color(0xFFEB1555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
