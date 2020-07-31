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
  void _changeLanguage(Language language) async{
    // create Locale based on lang selected using the dropdown
    Locale _temp = await setLocale(language.languageCode);

    // use MyApp (root) to be able to change the language
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    // app’s current locale
//    Locale myLocale = Localizations.localeOf(context);
//    print('myLocale is $myLocale');

    return Scaffold(
        drawer: _drawerList(),
        appBar: new AppBar(
            title: Text(appTitle),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: DropdownButton(
                  isDense: true,
                  onChanged: (Language language) {
                    _changeLanguage(language);
                  },
                  underline: SizedBox(), // hide underline
                  icon: Icon(
                    Icons.language,
                    color: Colors.white
                  ),
                  // map items in languageList
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                        value: lang,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(lang.name, style: TextStyle(fontSize: 20)),
                            Text(lang.flag)
                          ],
                        )
                      ))
                      .toList(), // convert iterable to list
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

//            BottomNavigationBarItem(
//                icon: Icon(Icons.favorite_border),
//                title: Text('Favorites')
//            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download),
                title: Text(getTranslated(context, "export"))
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
                radius: 10,
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
          ListTile(
            leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20
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
        ],
      ),
    );
  }
}
