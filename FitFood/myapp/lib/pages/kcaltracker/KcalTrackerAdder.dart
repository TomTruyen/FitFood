import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/services/Database.dart';
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
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: unitHeightValue * 56.0,
        title: Text(
          'Nutrition Adder',
          style: TextStyle(fontSize: unitHeightValue * 20.0),
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
  int kcal = 1250;
  int carbs = 100;
  int protein = 50;
  int fat = 50;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext build) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Card(
              cardColor: Color(0xFF1d1e33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'CALORIES',
                    style: TextStyle(
                        color: Color(0xFF8D8E98),
                        fontSize: unitHeightValue * 18.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        kcal.toString(),
                        style: TextStyle(
                            fontSize: unitHeightValue * 30.0,
                            fontWeight: FontWeight.w900),
                      ),
                      Text('KCAL',
                          style: TextStyle(fontSize: unitHeightValue * 18.0)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.minus, size: 20),
                        onPressed: () {
                          setState(() {
                            if (kcal > 0) {
                              kcal--;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Color(0xFF8D8E98),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0)),
                          child: Slider(
                              min: 0,
                              max: 2500,
                              value: kcal.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  kcal = value.round();
                                });
                              }),
                        ),
                      ),
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.plus, size: 20),
                        onPressed: () {
                          setState(() {
                            if (kcal < 2500) {
                              kcal++;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
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
                children: <Widget>[
                  Text(
                    'CARBS',
                    style: TextStyle(
                        color: Color(0xFF8D8E98),
                        fontSize: unitHeightValue * 18.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        carbs.toString(),
                        style: TextStyle(
                            fontSize: unitHeightValue * 30.0,
                            fontWeight: FontWeight.w900),
                      ),
                      Text('G',
                          style: TextStyle(fontSize: unitHeightValue * 18.0)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.minus,
                            size: unitHeightValue * 20.0),
                        onPressed: () {
                          setState(() {
                            if (carbs > 0) {
                              carbs--;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Color(0xFF8D8E98),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0)),
                          child: Slider(
                              min: 0,
                              max: 200,
                              value: carbs.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  carbs = value.round();
                                });
                              }),
                        ),
                      ),
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.plus, size: 20),
                        onPressed: () {
                          setState(() {
                            if (carbs < 200) {
                              carbs++;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
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
                children: <Widget>[
                  Text(
                    'PROTEIN',
                    style: TextStyle(
                        color: Color(0xFF8D8E98),
                        fontSize: unitHeightValue * 18.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        protein.toString(),
                        style: TextStyle(
                            fontSize: unitHeightValue * 30.0,
                            fontWeight: FontWeight.w900),
                      ),
                      Text('G',
                          style: TextStyle(fontSize: unitHeightValue * 18.0)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.minus, size: 20),
                        onPressed: () {
                          setState(() {
                            if (protein > 0) {
                              protein--;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Color(0xFF8D8E98),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0)),
                          child: Slider(
                              min: 0,
                              max: 100,
                              value: protein.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  protein = value.round();
                                });
                              }),
                        ),
                      ),
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.plus, size: 20),
                        onPressed: () {
                          setState(() {
                            if (protein < 100) {
                              protein++;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
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
                children: <Widget>[
                  Text('FAT',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        fat.toString(),
                        style: TextStyle(
                            fontSize: unitHeightValue * 30.0,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'G',
                        style: TextStyle(fontSize: unitHeightValue * 18.0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.minus, size: 20.0),
                        onPressed: () {
                          setState(() {
                            if (fat > 0) {
                              fat--;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Color(0xFF8D8E98),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0)),
                          child: Slider(
                              min: 0,
                              max: 100,
                              value: fat.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  fat = value.round();
                                });
                              }),
                        ),
                      ),
                      RawMaterialButton(
                        child: Icon(FontAwesomeIcons.plus, size: 20.0),
                        onPressed: () {
                          setState(() {
                            if (fat < 100) {
                              fat++;
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 6.0,
                        fillColor: Color(0xFFEB1555),
                        constraints:
                            BoxConstraints.tightFor(width: 30.0, height: 30.0),
                      ),
                    ],
                  ),
                ],
              ),
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
                time: globals.todayNutrition.time,
              );

              // ADD NUTRITION TO DATABASE
              bool isSaved = await addNutrition(
                nutrition,
              );

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
    );
  }
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
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
