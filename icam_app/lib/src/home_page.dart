import 'package:flutter/material.dart';
import 'package:icam_app/classes/language.dart';
import 'package:icam_app/localization/localization_constants.dart';
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
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

   // change locale based on locale selected by the user
  void _changeLanguage(Language language) async {
    // create Locale based on lang selected using the dropdown
    Locale _locale = await setLocale(language.languageCode);
    // use MyApp (root) to be able to change the language
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _drawerList(),
        appBar: new AppBar(
            title: Text(appTitle),
            actions: <Widget>[
              Padding(padding: EdgeInsets.all(8.0),
                child: DropdownButton(
                  onChanged: (Language language) {
                    _changeLanguage(language);
                  },
                  underline: SizedBox(), // hide underline
                  icon: Icon(Icons.language, color: Colors.white),
                  // map items in languageList
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(lang.name, style: TextStyle(fontSize: 30)),
                              Text(lang.flag)
                            ],
                          ),
                        );
                  }).toList(),// convert iterable to list
                ),
              )
            ]
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar:  BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text(getTranslated(context, "map"))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download),
                title: Text(getTranslated(context, "export"))
            )
          ],

          currentIndex: selectedIndex,
          selectedItemColor: myTheme.primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14.0,
          unselectedFontSize: 4.0,
          onTap: _onItemTapped,
        )
    );
  }

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 18
    );

    return Container(
      // get real screen resolution
      width: MediaQuery.of(context).size.width / 1.5,
      color: myTheme.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                children: <Widget>[
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 15),
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/images/user.png'),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                ),
                Text(
                  "Profile",
//                  getTranslated(context, "no_account"),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                ),
                Text(
                  "No account registered",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                ]
            )
          ),
          ListTile(
            leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 18
            ),
            title: Text(
              getTranslated(context, "settings"),
              style: _textStyle,
            ),
            onTap:(){
              // to close the drawer
              Navigator.pop(context);
              //navigate to about page
              Navigator.pushNamed(context, notFoundRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 18
            ),
            title: Text(
              getTranslated(context, "about"),
              style: _textStyle,
            ),
            onTap:(){
              // to close the drawer
              Navigator.pop(context);
              //navigate to about page
              Navigator.pushNamed(context, aboutRoute);
            },
          ),
        ],
      ),
    );
  }
}
