import 'package:flutter/material.dart';

class MacroCalculatorResultDetails extends StatelessWidget {
  final int kcal;

  MacroCalculatorResultDetails({Key key, @required this.kcal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: unitHeightValue * 56.0,
        title: Text(
          'Nutrition Details',
          style: TextStyle(fontSize: unitHeightValue * 20.0),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                cardColor: Color(0xFF1d1e33),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'LOSE WEIGHT',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          (kcal - 500).toString() +
                              "-" +
                              (kcal - 250).toString(),
                          style: TextStyle(
                              fontSize: unitHeightValue * 50.0,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'KCAL',
                          style: TextStyle(fontSize: unitHeightValue * 18.0),
                        ),
                      ],
                    ),
                    Text(
                      _calculateCarbsDeficit(kcal - 500, kcal - 250),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateProteinDeficit(kcal - 500, kcal - 250),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateFatDeficit(kcal - 500, kcal - 250),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
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
                      'MAINTAIN WEIGHT',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          kcal.toString(),
                          style: TextStyle(
                              fontSize: unitHeightValue * 50.0,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'KCAL',
                          style: TextStyle(fontSize: unitHeightValue * 18.0),
                        ),
                      ],
                    ),
                    Text(
                      _calculateCarbsMaintain(kcal),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateProteinMaintain(kcal),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateFatMaintain(kcal),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
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
                      'GAIN WEIGHT',
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          (kcal + 250).toString() +
                              "-" +
                              (kcal + 500).toString(),
                          style: TextStyle(
                              fontSize: unitHeightValue * 50.0,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'KCAL',
                          style: TextStyle(fontSize: unitHeightValue * 18.0),
                        ),
                      ],
                    ),
                    Text(
                      _calculateCarbsSurplus(kcal + 250, kcal + 500),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateProteinSurplus(kcal + 250, kcal + 500),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                    Text(
                      _calculateFatSurplus(kcal + 250, kcal + 500),
                      style: TextStyle(
                          color: Color(0xFF8D8E98),
                          fontSize: unitHeightValue * 18.0),
                    ),
                  ],
                ),
              ),
            ),
            // Text(kcal.toString()),
            // Text(
            //     "ADD THE EXACT MACRO'S HERE AND MORE INFORMATION FOR THE PERSON (SMALL TEXTS) "),
            // Text(
            //     "OP MOMENT GEEF MACRO CALCULATOR DE 'MAINTAIN' WEIGHT VALUE, DUS HIER MOET OOK NOG EEN MOGELIJKHEID KOMEN OM GEWICHT BIJ TE KOMEN / AF TE VALLEN (+250 KCAL OF +500KCAL VOOR DRASTISCH)")
          ],
        ),
      ),
    );
  }
}

String _calculateCarbsDeficit(int extremeChangeKCAL, int normalChangeKCAL) {
  int extremeCarbs = ((extremeChangeKCAL * 0.50) / 4.0).round();
  int normalCarbs = ((normalChangeKCAL * 0.50) / 4.0).round();

  String finalString = "Carbs: " +
      extremeCarbs.toString() +
      "g - " +
      normalCarbs.toString() +
      "g";

  return finalString;
}

String _calculateProteinDeficit(int extremeChangeKCAL, int normalChangeKCAL) {
  int extremeProtein = ((extremeChangeKCAL * 0.25) / 4.0).round();
  int normalProtein = ((normalChangeKCAL * 0.25) / 4.0).round();

  String finalString = "Protein: " +
      extremeProtein.toString() +
      "g - " +
      normalProtein.toString() +
      "g";

  return finalString;
}

String _calculateFatDeficit(int extremeChangeKCAL, int normalChangeKCAL) {
  int extremeFat = ((extremeChangeKCAL * 0.25) / 9.0).round();
  int normalFat = ((normalChangeKCAL * 0.25) / 9.0).round();

  String finalString =
      "Fat: " + extremeFat.toString() + "g - " + normalFat.toString() + "g";

  return finalString;
}

String _calculateCarbsMaintain(int kcal) {
  int carbs = ((kcal * 0.50) / 4.0).round();

  String finalString = "Carbs: " + carbs.toString() + "g";

  return finalString;
}

String _calculateProteinMaintain(int kcal) {
  int protein = ((kcal * 0.25) / 4.0).round();

  String finalString = "Protein: " + protein.toString() + "g";

  return finalString;
}

String _calculateFatMaintain(int kcal) {
  int fat = ((kcal * 0.25) / 9.0).round();

  String finalString = "Fat: " + fat.toString() + "g";

  return finalString;
}

String _calculateCarbsSurplus(int normalChangeKCAL, int extremeChangeKCAL) {
  int normalCarbs = ((normalChangeKCAL * 0.50) / 4.0).round();
  int extremeCarbs = ((extremeChangeKCAL * 0.50) / 4.0).round();

  String finalString = "Carbs: " +
      normalCarbs.toString() +
      "g - " +
      extremeCarbs.toString() +
      "g";

  return finalString;
}

String _calculateProteinSurplus(int normalChangeKCAL, int extremeChangeKCAL) {
  int normalProtein = ((normalChangeKCAL * 0.25) / 4.0).round();
  int extremeProtein = ((extremeChangeKCAL * 0.25) / 4.0).round();

  String finalString = "Protein: " +
      normalProtein.toString() +
      "g - " +
      extremeProtein.toString() +
      "g";

  return finalString;
}

String _calculateFatSurplus(int normalChangeKCAL, int extremeChangeKCAL) {
  int normalFat = ((normalChangeKCAL * 0.25) / 9.0).round();
  int extremeFat = ((extremeChangeKCAL * 0.25) / 9.0).round();

  String finalString =
      "Fat: " + normalFat.toString() + "g - " + extremeFat.toString() + "g";

  return finalString;
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
