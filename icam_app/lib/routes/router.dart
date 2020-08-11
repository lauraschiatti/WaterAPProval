import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/src/about.dart';
import 'package:icam_app/src/settings.dart';
import 'package:icam_app/src/home_page.dart';
import 'package:icam_app/src/map_page.dart';
import 'package:icam_app/src/cartagena.dart';
import 'package:icam_app/src/not_found.dart';
import 'package:icam_app/src/nodes/node_details.dart';

import 'route_names.dart';

class Router {
  // is called everytime we navigate from a page to another
  static Route<dynamic> generateRoute(RouteSettings settings) {

    // determine which view to return according to requested route
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case mapRoute:
        return MaterialPageRoute(builder: (_) => MapControllerPage());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case cgenaRoute:
        return MaterialPageRoute(builder: (_) => CartagenaPage());

      case nodeDetailRoute:
        var node = settings.arguments as Node;
        return MaterialPageRoute(builder: (_) => NodeDetailPage(node));
    }

    // if none of the cases matches
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}