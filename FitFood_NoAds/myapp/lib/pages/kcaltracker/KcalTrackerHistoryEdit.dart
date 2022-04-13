import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/shared/Functions.dart';
import 'package:myapp/shared/Globals.dart' as globals;

class KcalTrackerHistoryEdit extends StatelessWidget {
  final Nutrition nutrition;
  final Function refresh;

  const KcalTrackerHistoryEdit({
    Key key,
    @required this.nutrition,
    @required this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int kcal = nutrition.kcal;
    int carbs = nutrition.carbs;
    int protein = nutrition.protein;
    int fat = nutrition.fat;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit History',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              Nutrition _nutrition = Nutrition(
                  kcal: kcal,
                  carbs: carbs,
                  protein: protein,
                  fat: fat,
                  time: nutrition.time);

              // ADD NUTRITION TO DATABASE
              bool isSaved = await globals.sqlDatabase.overrideNutrition(
                _nutrition,
              );

              bool isRefreshed = await refresh();

              if (isSaved && isRefreshed) {
                tryPopContext(context);
                tryPopContext(context);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: kcal.toString(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: '0',
                  suffix: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('KCAL'),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  if (value == "") value = "0";

                  kcal = int.parse(value);
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: carbs.toString(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: '0',
                  suffix: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('CARBS'),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  if (value == "") value = "0";

                  carbs = int.parse(value);
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: protein.toString(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: '0',
                  suffix: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('PROTEIN'),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  if (value == "") value = "0";

                  protein = int.parse(value);
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: fat.toString(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: '0',
                  suffix: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('FAT'),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {
                  if (value == "") value = "0";

                  fat = int.parse(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
