import 'package:flutter/material.dart';
import 'package:icam_app/classes/language.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';

import 'map_page.dart';
import 'settings.dart';

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
       appBar: AppBar(
         title: Text(appTitle),
         actions: <Widget>[
           IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
               //navigate to about page
//               Navigator.pushNamed(context, infoRoute);
             },
           ),
           // overflow menu
           PopupMenuButton(
              onSelected: (Language language) {
                _changeLanguage(language);
              },
              icon: Icon(Icons.translate, color: Colors.white),
              itemBuilder: (BuildContext context) {
                 return Language.languageList()
                    .map<PopupMenuItem<Language>>((lang) {
                    return PopupMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(lang.name, style: TextStyle(fontSize: 30)),
                          Text(lang.flag)
                        ],
                      )
                    );
                }).toList();
             },
           ),
         ],
       ),
        drawer: _drawerList(),
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
          selectedFontSize: 16.0,
          unselectedFontSize: 14.0,
          onTap: _onItemTapped,
        )
    );
  }

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      fontSize: 16
    );

    return Container(
      // get real screen resolution
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: myTheme.primaryColor
            ),
            child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 15),
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset('assets/images/user.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(getTranslated(context, "profile"),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(getTranslated(context, "no_account"),
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
                Icons.import_contacts,
                size: 18
            ),
            title: Text(
//              appTitle + " " + getTranslated(context, "encyclopedia"),
              getTranslated(context, "encyclopedia"),
              style: _textStyle,
            ),
            onTap:(){
              print("Encyclopedia");
//              // to close the drawer
//              Navigator.pop(context);
//              //navigate to about page
//              Navigator.pushNamed(context, notFoundRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.access_alarms,
                size: 18
            ),
            title: Text(
              getTranslated(context, "reminders"),
              style: _textStyle,
            ),
            onTap:(){
              print("Reminders");
//              // to close the drawer
//              Navigator.pop(context);
//              //navigate to about page
//              Navigator.pushNamed(context, notFoundRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.settings,
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
              Navigator.pushNamed(context, settingsRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.share,
                size: 18
            ),
            title: Text(
              getTranslated(context, "tell_friends"), // + appTitle,
              style: _textStyle,
            ),
            onTap:(){
              print("Tell friends about");
//              // to close the drawer
//              Navigator.pop(context);
//              //navigate to about page
//              Navigator.pushNamed(context, notFoundRoute);
            },
          ),
          Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: Icon(
            Icons.format_indent_increase,
            size: 18
            ),
            title: Text(
            getTranslated(context, "terms"),
            style: _textStyle,
            ),
            onTap:(){
              print("Terms of Service");
//              // to close the drawer
//              Navigator.pop(context);
//              //navigate to about page
//              Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.info_outline,
                size: 18
            ),
            title: Text(
              getTranslated(context, "about"),
              style: _textStyle,
            ),
            onTap:(){
              print("About");
              // to close the drawer
              Navigator.pop(context);
              //navigate to about page
              Navigator.pushNamed(context, aboutRoute);
            },
          )
        ],
      ),
    );
  }
}
