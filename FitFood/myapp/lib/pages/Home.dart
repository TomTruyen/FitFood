import 'package:flutter/material.dart';
import 'package:myapp/pages/kcaltracker/KcalTracker.dart';
import 'package:myapp/pages/macrocalculator/MacroCalculator.dart';

class HomePage extends StatefulWidget {
  final bool adLoaded;
  final int selectedIndex;

  HomePage({this.adLoaded = false, this.selectedIndex = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> titles = ['Kcal Tracker', 'Kcal Calculator'];
  List<Widget> pages;

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedIndex = widget.selectedIndex;
      pages = [KcalTracker(), MacroCalculator()];
    });
  }

  // Should contain the drawer & appbar, which can switch between the 2 pages, should also load all data from database before dispalying anything
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: Container(
        width: unitHeightValue * 300.0,
        color: Color(0xFF1d1e33),
        child: ListView(
          children: <Widget>[
            Container(
              height: 64.0,
              child: DrawerHeader(
                child: Text(
                  'FitFood',
                  style: TextStyle(
                      fontSize: unitHeightValue * 26.0, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFEB1555),
                ),
              ),
            ),
            ListTile(
              title: Text(
                titles[0],
                style: TextStyle(fontSize: unitHeightValue * 20.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                titles[1],
                style: TextStyle(fontSize: unitHeightValue * 20.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: pages == null ? KcalTracker() : pages[selectedIndex],
    );
  }
}
