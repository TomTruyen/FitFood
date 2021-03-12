import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/pages/macrocalculator/MacroCalculatorResultDetails.dart';

class MacroCalculatorResult extends StatelessWidget {
  final String gender;
  final int height;
  final int weight;
  final int age;

  MacroCalculatorResult(
      {Key key, @required this.gender, this.height, this.weight, this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: unitHeightValue * 56.0,
        title: Text(
          'Nutrition Results',
          style: TextStyle(fontSize: unitHeightValue * 20.0),
        ),
      ),

      /*Make macro + kcal adder here with input fields for every thing*/
      /* Add the data with button to database and then let button get us back to KcalTracker*/
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'NUTRITION RESULTS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: unitHeightValue * 25.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'NOTE: These value should be used to maintain current weight. If you want to gain / lose weight please click on the arrow of the box that matches your activity.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: unitHeightValue * 16.0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                cardColor: Color(0xFF1d1e33),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'NO EXERCISE',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              _calculateKCAL(gender, height, weight, age, 0)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: unitHeightValue * 50.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'KCAL',
                              style:
                                  TextStyle(fontSize: unitHeightValue * 18.0),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              int kcal = _calculateKCAL(
                                  gender, height, weight, age, 0);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  fullscreenDialog: false,
                                  builder: (BuildContext context) =>
                                      MacroCalculatorResultDetails(kcal: kcal),
                                ),
                              );
                            },
                            child: Icon(FontAwesomeIcons.chevronCircleRight,
                                size: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                cardColor: Color(0xFF1d1e33),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '1-3 TIMES/WEEK',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              _calculateKCAL(gender, height, weight, age, 1)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: unitHeightValue * 50.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'KCAL',
                              style:
                                  TextStyle(fontSize: unitHeightValue * 18.0),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              int kcal = _calculateKCAL(
                                  gender, height, weight, age, 1);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  fullscreenDialog: false,
                                  builder: (BuildContext context) =>
                                      MacroCalculatorResultDetails(kcal: kcal),
                                ),
                              );
                            },
                            child: Icon(FontAwesomeIcons.chevronCircleRight,
                                size: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                cardColor: Color(0xFF1d1e33),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '3-5 TIMES/WEEK',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              _calculateKCAL(gender, height, weight, age, 2)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: unitHeightValue * 50.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'KCAL',
                              style:
                                  TextStyle(fontSize: unitHeightValue * 18.0),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              int kcal = _calculateKCAL(
                                  gender, height, weight, age, 2);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  fullscreenDialog: false,
                                  builder: (BuildContext context) =>
                                      MacroCalculatorResultDetails(kcal: kcal),
                                ),
                              );
                            },
                            child: Icon(FontAwesomeIcons.chevronCircleRight,
                                size: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                cardColor: Color(0xFF1d1e33),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '6-7 TIMES/WEEK',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              _calculateKCAL(gender, height, weight, age, 3)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: unitHeightValue * 50.0,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'KCAL',
                              style:
                                  TextStyle(fontSize: unitHeightValue * 18.0),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              int kcal = _calculateKCAL(
                                  gender, height, weight, age, 3);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  fullscreenDialog: false,
                                  builder: (BuildContext context) =>
                                      MacroCalculatorResultDetails(kcal: kcal),
                                ),
                              );
                            },
                            child: Icon(FontAwesomeIcons.chevronCircleRight,
                                size: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _calculateKCAL(
    String gender, int height, int weight, int age, activityLevelCode) {
  List<double> activityLevel = [1.2, 1.375, 1.55, 1.725];
  //0 = litle or no exercise
  //1 = exercise 1 -3 x / week
  //2 = exercise 3 -5 x / week
  //3 = exercise 6 -7 x / week

  //The Revised Harris-Benedict Equation https://bmi-calories.com/calorie-intake-calculator.html
  double totalCalories = 0;
  if (gender == 'Gender.Male') {
    totalCalories =
        88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else {
    totalCalories =
        447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }

  totalCalories *= activityLevel[activityLevelCode];

  return totalCalories.round();
}

class Card extends StatelessWidget {
  final Color cardColor;
  final Widget cardChild;
  final Function onPressed;

  Card({@required this.cardColor, this.cardChild, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: cardChild,
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
