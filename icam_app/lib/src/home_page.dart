import 'package:flutter/material.dart';
import 'package:icam_app/models/language.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/theme.dart';

import 'map_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //BottomNavigationBarItem

  int selectedIndex = 0;

  // TODO: different background color for listtile
  // https://github.com/flutter/flutter/issues/7499

  List<Widget> widgetOptions = <Widget>[
    MapControllerPage(),
    Text('Export data'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  //changeLanguage DropdownButton

  // change locale based on locale selected by the user
  void _changeLanguage(Language language) async {
    // create Locale based on lang selected using the dropdown
    Locale _locale = await setLocale(language.languageCode);
    // use MyApp (root) to be able to change the language
    MyApp.setLocale(context, _locale);
  }

  // Drawer

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
               Navigator.pushNamed(context, infoRoute);
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
        drawer: DrawerList(),
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
}

class DrawerList extends StatefulWidget{
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {

  @override
  void initState() {
    super.initState();
//    _color = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // get real screen resolution
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(context),
          _buildListTile(
              context: context,
              icon: Icons.import_contacts,
              title: "encyclopedia",
              route: notFoundRoute
          ),
          _buildListTile(
              context: context,
              icon: Icons.access_alarms,
              title: "reminders",
              route: notFoundRoute
          ),
          SizedBox(
            width: 10.0,
          ),
          _buildListTile(
              context: context,
              icon: Icons.settings,
              title: "settings",
              route: settingsRoute
          ),
          _buildListTile(
              context: context,
              icon: Icons.share,
              title: "tell_friends",
              route: notFoundRoute
          ),
          _buildListTile(
              context: context,
              icon: Icons.format_indent_increase,
              title: "terms",
              route: notFoundRoute
          ),
          _buildListTile(
              context: context,
              icon: Icons.info_outline,
              title: "about",
              route: aboutRoute
          )
        ],
      ),
    );
  }
}

DrawerHeader _buildDrawerHeader(context){
  return DrawerHeader(
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
  );
}


ListTile _buildListTile({context, icon, title, route}){
  return ListTile(
    leading: Icon(
        icon,
        size: 18
    ),
    title: Text(getTranslated(context, title),
      style: TextStyle(fontSize: 16),
    ),
    onTap:(){
      print(title);
      // to close the drawer
      Navigator.pop(context);
      //navigate to about page
      Navigator.pushNamed(context, route);

//      setState(() {
//                _color = Colors.lightBlueAccent;
//      });
    },
  );
}