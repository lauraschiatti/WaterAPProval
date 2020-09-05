
import 'package:flutter/material.dart';
import 'package:icam_app/models/language.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/ui/info_page.dart';
import 'package:icam_app/ui/favorites_page.dart';
import 'package:icam_app/theme.dart';

import 'package:icam_app/ui/export_page.dart';
import 'package:icam_app/ui/explore_data.dart';
import 'package:icam_app/ui/map_page.dart';

class HomePage extends StatefulWidget {
  HomePage(); // {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //BottomNavigationBarItem
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    MapControllerPage(),
    ExportControllerPage(),
//    ExploreDataPage(),
    FavoritePage(),
    InfoPage()
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
        appBar: _buildAppBar(),
        drawer: DrawerList(),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
//            Center(child: Text('Connection Status: $_connectionStatus')),
//            NetworkSensitive(child: _buildSimpleSnackBar()),
        bottomNavigationBar:  _buildBottomNavigationBar()
    );
  }


  _buildAppBar(){
    return AppBar(
      title: Text(appTitle),
      actions: <Widget>[
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
    );
  }

  // bottomNavigationBar
  _buildBottomNavigationBar(){
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text(getTranslated(context, "map"))
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text(getTranslated(context, "data"))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text(getTranslated(context, "favorites")),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Info")
        )
      ],

      currentIndex: selectedIndex,
      selectedItemColor: myTheme.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 16.0,
      unselectedFontSize: 14.0,
      onTap: _onItemTapped,
    );
  }

}



// Drawer
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
      child: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(context),
            _buildListTile(
                context: context,
                icon: Icons.import_contacts,
                title: "encyclopedia",
                route: encyclopediaRoute
            ),
            _buildListTile(
                context: context,
                icon: Icons.phone_android,
                title: "calculator",
                route: calculatorRoute
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
            // TODO: tell friends
//          _buildListTile(
//              context: context,
//              icon: Icons.share,
//              title: "tell_friends",
//              route: notFoundRoute
//          ),
            _buildListTile(
                context: context,
                icon: Icons.format_indent_increase,
                title: "terms",
                route: notFoundRoute
            ),
            _buildListTile(
                context: context,
                icon: Icons.info_outline,
                title: "info_app",
                route: aboutRoute
            )
          ],
        )
      )
    );
  }
}

_buildDrawerHeader(context){
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

_buildListTile({context, icon, title, route}){
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
//          color = Colors.lightBlueAccent;
//      });
    },
  );
}


// network connection
//class NetworkSensitive extends StatelessWidget {
//  final Widget child;
//
//
//  NetworkSensitive({
//    this.child,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    var connectionStatus = Provider.of<ConnectivityStatus>(context);
//
//    if (connectionStatus == ConnectivityStatus.WiFi) {
//      return child;
//    }
//
//    if (connectionStatus == ConnectivityStatus.Cellular) {
//      return Container(child: Text('Koneksi Mobile'), );
//    }
//
//    if (connectionStatus == ConnectivityStatus.Offline) {
//      return Container(child: Text('Koneksi Offline'), );
//    }
//  }
//}