import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNutritionCard extends StatelessWidget {
  final String text;
  final int value;
  final double maxValue;
  final TextEditingController controller;
  final double textHeightUnit;
  final Function(String) onChanged;

  const AddNutritionCard({
    Key key,
    this.text,
    this.value,
    this.maxValue,
    this.controller,
    this.textHeightUnit,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF1d1e33),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF8D8E98),
                fontSize: textHeightUnit * 18.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      hintText: '0',
                    ),
                    style: TextStyle(
                      fontSize: textHeightUnit * 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  child: Icon(FontAwesomeIcons.minus, size: 20),
                  onPressed: () {
                    if (value > 0) {
                      int newValue = value - 1;

                      onChanged.call(newValue.toString());
                    }
                  },
                  shape: CircleBorder(),
                  elevation: 6.0,
                  fillColor: Color(0xFFEB1555),
                  constraints: BoxConstraints.tightFor(
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15.0,
                      ),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                        min: 0,
                        max: value > maxValue ? value.toDouble() : maxValue,
                        value: value.toDouble(),
                        onChanged: (double value) {
                          onChanged.call(value.round().toString());
                        }),
                  ),
                ),
                RawMaterialButton(
                  child: Icon(FontAwesomeIcons.plus, size: 20),
                  onPressed: () {
                    int newValue = value + 1;

                    onChanged.call(newValue.toString());
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
    );
  }
}
