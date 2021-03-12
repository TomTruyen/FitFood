import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String text;
  final Color color;

  Loading({this.text = "", this.color});

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Container(
      color: color == null ? Color(0xFF1d1e33) : color,
      child: Center(
        child: text == ""
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFEB1555),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFEB1555),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: unitHeightValue * 20.0,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
