import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/pages/kcaltracker/KcalTrackerHistoryEdit.dart';
import 'package:myapp/shared/Functions.dart';
import 'package:myapp/shared/Globals.dart' as globals;
import 'package:myapp/shared/Loading.dart';

class KcalTrackerHistoryDetail extends StatelessWidget {
  final List<Nutrition> nutritionList;
  final Nutrition nutrition;
  final int index;
  final Function refreshNutrition;

  KcalTrackerHistoryDetail({
    Key key,
    @required this.nutritionList,
    @required this.nutrition,
    @required this.index,
    @required this.refreshNutrition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    void _showDialog() {
      bool isDeleting = false;

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
                  return isDeleting
                      ? Container(
                          height: 150.0,
                          child: Loading(text: 'Deleting...'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Delete Nutrition History',
                                  style: TextStyle(
                                    fontSize: unitHeightValue * 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Are you sure you want to delete this?',
                                  style: TextStyle(
                                    fontSize: unitHeightValue * 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: unitHeightValue * 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: unitHeightValue * 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        isDeleting = true;
                                      });

                                      // REMOVE NUTRITION VALUE
                                      bool isDeleted = await globals.sqlDatabase
                                          .deleteNutrition(
                                        nutrition.time,
                                      );

                                      bool isRefreshed =
                                          await refreshNutrition();

                                      if (isDeleted && isRefreshed) {
                                        tryPopContext(context);
                                        tryPopContext(context);
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrition History',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => KcalTrackerHistoryEdit(
                      nutrition: nutrition,
                      refresh: refreshNutrition,
                    ),
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDialog();
            },
          )
        ],
      ),

      /*Make macro + kcal adder here with input fields for every thing*/
      /* Add the data with button to database and then let button get us back to KcalTracker*/
      body: HistoryDetailCodeState(nutrition: nutrition),
    );
  }
}

class HistoryDetailCodeState extends StatefulWidget {
  final Nutrition nutrition;
  HistoryDetailCodeState({Key key, @required this.nutrition}) : super(key: key);

  @override
  HistoryDetailCode createState() => HistoryDetailCode(nutrition: nutrition);
}

class HistoryDetailCode extends State<HistoryDetailCodeState> {
  final Nutrition nutrition;
  HistoryDetailCode({Key key, @required this.nutrition});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Card(
              cardColor: Color(0xFF1d1e33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'HISTORY OF',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      _getFullDate(nutrition.time),
                      style: TextStyle(
                          fontSize: unitHeightValue * 30.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              cardColor: Color(0xFF1d1e33),
              cardChild: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      //GET KCAL HERE
                      nutrition.kcal.toString(),
                      style: TextStyle(
                          fontSize: unitHeightValue * 50.0,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'KCAL',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    cardColor: Color(0xFF1d1e33),
                    cardChild: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: Colors.blue[700],
                                        height: 18.0,
                                        width: 18.0,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        'Carbs (' +
                                            nutrition.carbs.toString() +
                                            'g)',
                                        style: TextStyle(
                                            fontSize: unitHeightValue * 18.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: Colors.green[700],
                                        height: 18.0,
                                        width: 18.0,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        'Protein (' +
                                            nutrition.protein.toString() +
                                            'g)',
                                        style: TextStyle(
                                            fontSize: unitHeightValue * 18.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: Colors.red[700],
                                        height: 18.0,
                                        width: 18.0,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        'Fat (' +
                                            nutrition.fat.toString() +
                                            'g)',
                                        style: TextStyle(
                                            fontSize: unitHeightValue * 18.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: GaugeChart(_createData(
                              double.parse(nutrition.carbs.toString()),
                              double.parse(nutrition.protein.toString()),
                              double.parse(nutrition.fat.toString()))),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_getFullDate(String date) {
  List splittedDate = date.split('-');

  DateTime parsedDate = DateTime(int.parse(splittedDate[2]),
      int.parse(splittedDate[1]), int.parse(splittedDate[0]));

  String fullDate =
      "${parsedDate.day} ${DateFormat.MMMM().format(parsedDate)} ${parsedDate.year}";

  return fullDate;
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
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: false,
      defaultRenderer: new charts.ArcRendererConfig(
          strokeWidthPx: 0.0,
          arcWidth: 20,
          startAngle: 3 / 2 * pi,
          arcLength: 2 * pi),
    );
  }
}

List<charts.Series<GaugeSegment, String>> _createData(
    double carbs, double protein, double fat) {
  // final blue = charts.MaterialPalette.blue.makeShades(0);
  final blue = charts.MaterialPalette.blue.shadeDefault.darker;
  final red = charts.MaterialPalette.red.shadeDefault.darker;
  final green = charts.MaterialPalette.green.shadeDefault.darker;
  final gray = charts.MaterialPalette.gray.shadeDefault.darker;

  if (carbs == 0 && protein == 0 && fat == 0) {
    final data = [new GaugeSegment('Random', 1)];

    return [
      new charts.Series<GaugeSegment, String>(
          id: 'Segments',
          domainFn: (GaugeSegment segment, _) => segment.segment,
          measureFn: (GaugeSegment segment, _) => segment.size,
          data: data,
          colorFn: (GaugeSegment segment, _) {
            switch (segment.segment) {
              case "Carbs":
                {
                  return blue;
                }
              case "Protein":
                {
                  return green;
                }
              case "Fat":
                {
                  return red;
                }
              default:
                {
                  return gray;
                }
            }
          })
    ];
  } else {
    /* Get data from localStorage of macro's here*/
    final data = [
      /* Instead of final data maybe try List<GaugeSegment> data????*/
      new GaugeSegment('Carbs', carbs.round()),
      new GaugeSegment('Protein', protein.round()),
      new GaugeSegment('Fat', fat.round()),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
          id: 'Segments',
          domainFn: (GaugeSegment segment, _) => segment.segment,
          measureFn: (GaugeSegment segment, _) => segment.size,
          data: data,
          colorFn: (GaugeSegment segment, _) {
            switch (segment.segment) {
              case "Carbs":
                {
                  return blue;
                }
              case "Protein":
                {
                  return green;
                }
              case "Fat":
                {
                  return red;
                }
              default:
                {
                  return gray;
                }
            }
          })
    ];
  }
}

class GaugeSegment {
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
