import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myapp/pages/macrocalculator/MacroCalculatorResult.dart';
import 'package:myapp/services/AdManager.dart';

enum Gender { Male, Female }
Gender gender = Gender.Male;
int height = 180;
int weight = 75;
int age = 18;

class MacroCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStateWidget();
  }
}

class MyStateWidget extends StatefulWidget {
  @override
  MacroBody createState() => MacroBody();
}

class MacroBody extends State<MyStateWidget> {
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
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      onPressed: () {
                        setState(() {
                          gender = Gender.Male;
                        });
                      },
                      cardColor: gender == Gender.Male
                          ? Color(0xFF1d1e33)
                          : Color(0xFF1d1e28),
                      cardChild: CardDetail(
                          label: 'MALE', iconname: FontAwesomeIcons.mars),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      onPressed: () {
                        setState(() {
                          gender = Gender.Female;
                        });
                      },
                      cardColor: gender == Gender.Female
                          ? Color(0xFF1d1e33)
                          : Color(0xFF1d1e28),
                      cardChild: CardDetail(
                          label: 'FEMALE', iconname: FontAwesomeIcons.venus),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
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
                          height.toString(),
                          style: TextStyle(
                              fontSize: unitHeightValue * 50.0,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'CM',
                          style: TextStyle(
                              color: Color(0xFF8D8E98),
                              fontSize: unitHeightValue * 18.0),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Color(0xFF8D8E98),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Slider(
                          min: 100,
                          max: 250,
                          value: height.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              height = value.round();
                            });
                          }),
                    )
                  ],
                ),
                cardColor: Color(0xFF1d1e33),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: TextStyle(
                                color: Color(0xFF8D8E98),
                                fontSize: unitHeightValue * 18.0),
                          ),
                          Text(
                            weight.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: unitHeightValue * 50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RawMaterialButton(
                                child: Icon(FontAwesomeIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    if (weight > 0) {
                                      weight--;
                                    }
                                  });
                                },
                                shape: CircleBorder(),
                                elevation: 6.0,
                                fillColor: Color(0xFFEB1555),
                                constraints: BoxConstraints.tightFor(
                                    width: 56.0, height: 56.0),
                              ),
                              SizedBox(width: 10.0),
                              RawMaterialButton(
                                child: Icon(FontAwesomeIcons.plus),
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                shape: CircleBorder(),
                                elevation: 6.0,
                                fillColor: Color(0xFFEB1555),
                                constraints: BoxConstraints.tightFor(
                                    width: 56.0, height: 56.0),
                              ),
                            ],
                          )
                        ],
                      ),
                      cardColor: Color(0xFF1d1e33),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: TextStyle(
                                color: Color(0xFF8D8E98),
                                fontSize: unitHeightValue * 18.0),
                          ),
                          Text(
                            age.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: unitHeightValue * 50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RawMaterialButton(
                                child: Icon(FontAwesomeIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    if (age > 0) {
                                      age--;
                                    }
                                  });
                                },
                                shape: CircleBorder(),
                                elevation: 6.0,
                                fillColor: Color(0xFFEB1555),
                                constraints: BoxConstraints.tightFor(
                                    width: 56.0, height: 56.0),
                              ),
                              SizedBox(width: 10.0),
                              RawMaterialButton(
                                child: Icon(FontAwesomeIcons.plus),
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                shape: CircleBorder(),
                                elevation: 6.0,
                                fillColor: Color(0xFFEB1555),
                                constraints: BoxConstraints.tightFor(
                                    width: 56.0, height: 56.0),
                              ),
                            ],
                          )
                        ],
                      ),
                      cardColor: Color(0xFF1d1e33),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (adLoaded) {
                  myAd.show();
                  adLoaded = false;
                  loadInterstitialAd();
                }

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => MacroCalculatorResult(
                      gender: gender.toString(),
                      height: height.toInt(),
                      weight: weight.toInt(),
                      age: age.toInt(),
                    ),
                  ),
                );
              },
              child: Container(
                child: Center(
                  child: Text('CALCULATE',
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

class CardDetail extends StatelessWidget {
  final String label;
  final IconData iconname;

  CardDetail({@required this.iconname, @required this.label});

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconname,
          size: 80,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: TextStyle(
              color: Color(0xFF8D8E98), fontSize: unitHeightValue * 18.0),
        ),
      ],
    );
  }
}
