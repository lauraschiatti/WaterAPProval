import 'package:flutter/material.dart';

import 'package:icam_app/theme.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

//  static const routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    Text('Home'),
    Text('Favorites'),
    Text('Export data'),
    Text('About')
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar:  BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search')
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text('Favorites')
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Notifications')
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile')
            )
          ],

          currentIndex: selectedIndex,
          selectedItemColor: myTheme.primaryColor,
          type: BottomNavigationBarType.fixed,
          //        selectedFontSize: 14.0,
          //        unselectedFontSize: 14.0,
          onTap: _onItemTapped,
        )
    );
  }

}
