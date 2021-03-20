import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myapp/models/Nutrition.dart';
import 'package:myapp/pages/kcaltracker/KcalTrackerAdder.dart';
import 'package:myapp/pages/kcaltracker/KcalTrackerHistoryDetail.dart';
import 'package:myapp/services/AdManager.dart';
import 'package:myapp/shared/Globals.dart' as globals;

class KcalTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KcalTrackerState();
  }
}

class KcalTrackerState extends StatefulWidget {
  @override
  KcalTrackerCode createState() => KcalTrackerCode();
}

class KcalTrackerCode extends State<KcalTrackerState> {
  List<Nutrition> nutrition = [];
  Nutrition todayNutrition;

  InterstitialAd myAd;
  bool adLoaded = false;

  InterstitialAd getInterstitial() {
    return InterstitialAd(
      adUnitId: AdManager.adUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            adLoaded = true;
          });
        },
      ),
    );
  }

  void loadInterstitialAd() {
    myAd?.dispose();

    myAd = getInterstitial()..load();
  }

  @override
  void initState() {
    super.initState();

    loadInterstitialAd();

    setState(() {
      nutrition = globals.sqlDatabase.nutrition ?? [];
      todayNutrition = globals.sqlDatabase.todayNutrition;
    });
  }

  Future<bool> refreshNutrition() async {
    await globals.sqlDatabase.refreshNutrition();

    setState(() {
      nutrition = globals.sqlDatabase.nutrition;
      todayNutrition = globals.sqlDatabase.todayNutrition;
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      body: RefreshIndicator(
        displacement: 20.0,
        color: Color(0xFFEB1555),
        onRefresh: () async {
          return await refreshNutrition();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                                todayNutrition.kcal.toString(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                                      todayNutrition.carbs
                                                          .toString() +
                                                      'g)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          unitHeightValue *
                                                              18.0),
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
                                                      todayNutrition.protein
                                                          .toString() +
                                                      'g)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          unitHeightValue *
                                                              18.0),
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
                                                      todayNutrition.fat
                                                          .toString() +
                                                      'g)',
                                                  style: TextStyle(
                                                      fontSize:
                                                          unitHeightValue *
                                                              18.0),
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
                                        double.parse(
                                            todayNutrition.carbs.toString()),
                                        double.parse(
                                            todayNutrition.protein.toString()),
                                        double.parse(
                                            todayNutrition.fat.toString()))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Card(
                        cardColor: Color(0xFF1d1e33),
                        cardChild: ListView.builder(
                          itemCount: nutrition.length,
                          itemBuilder: (context, int i) => Column(
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  nutrition[i].time,
                                  style: TextStyle(
                                      fontSize: unitHeightValue * 18.0),
                                ),
                                title: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                      text: nutrition[i].kcal.toString(),
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 20.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'KCAL',
                                          style: TextStyle(
                                              color: Color(0xFF8D8E98),
                                              fontSize: unitHeightValue * 14.0),
                                        ),
                                      ]),
                                ),
                                trailing: Icon(
                                    FontAwesomeIcons.chevronCircleRight,
                                    size: 20.0),
                                onTap: () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      fullscreenDialog: false,
                                      builder: (BuildContext context) =>
                                          KcalTrackerHistoryDetail(
                                        nutritionList: List.of(nutrition),
                                        nutrition: nutrition[i],
                                        index: i,
                                        refreshNutrition: refreshNutrition,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (adLoaded) {
                          myAd.show();
                          adLoaded = false;
                          loadInterstitialAd();
                        }

                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) => KcalTrackerAdder(
                              nutrition: List.of(nutrition),
                              todayNutrition: todayNutrition,
                              refreshNutrition: refreshNutrition,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        height: 80.0,
                        margin: EdgeInsets.only(top: 10.0),
                        color: Color(0xFFEB1555),
                      ),
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
        arcLength: 2 * pi,
      ),
    );
  }
}

List<charts.Series<GaugeSegment, String>> _createData(
    double carbs, double protein, double fat) {
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
          strokeWidthPxFn: (GaugeSegment segment, _) => 0.0,
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

class ListViewModel {
  final String leadingTitle;
  final String trailingTitle;

  ListViewModel({this.leadingTitle, this.trailingTitle});
}
