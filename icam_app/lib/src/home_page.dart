import 'package:flutter/material.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';

import 'map_page.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    MapControllerPage(),
    Text('Export data'),
    AboutPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _drawerList(),
        appBar: new AppBar(
            title: Text(appTitle),
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar:  BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Map')
            ),

//            BottomNavigationBarItem(
//                icon: Icon(Icons.favorite_border),
//                title: Text('Favorites')
//            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download),
                title: Text('Export data')
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

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20
    );

    return Container(
      // get real screen resolution
      width: MediaQuery.of(context).size.width / 1.5,
      color: myTheme.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 100,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
        //                            child: PNetworkImage(rocket),
              )
            )
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 20
            ),
            title: Text(
              "About Us",
              style: _textStyle,
            ),
            onTap:(){
              // to close the drawer
              Navigator.pop(context);
              //navigate to about page
              Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20
            ),
            title: Text(
              "Settings",
              style: _textStyle,
            ),
            onTap:(){
              // to close the drawer
              Navigator.pop(context);
              //navigate to about page
              Navigator.pushNamed(context, notFoundRoute);
            },
          ),
        ],
      ),
    );
  }
}
