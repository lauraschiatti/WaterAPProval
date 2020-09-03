import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/models/water_body.dart';
import 'package:icam_app/src/about.dart';
import 'package:icam_app/src/export_page.dart';
import 'package:icam_app/src/encyclopedia_page.dart';
import 'package:icam_app/src/nodes/nodes_show.dart';
import 'package:icam_app/src/settings.dart';
import 'package:icam_app/src/home_page.dart';
import 'package:icam_app/src/map_page.dart';
import 'package:icam_app/src/cartagena.dart';
import 'package:icam_app/src/not_found.dart';
import 'package:icam_app/src/nodes/node_details.dart';
import 'package:icam_app/src/water_body_data_page.dart';

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
      case exportRoute:
        return MaterialPageRoute(builder: (_) => ExportControllerPage());
      case encyclopediaRoute:
        return MaterialPageRoute(builder: (_) => EncyclopediaPage());

      case waterBodyDataPageRoute:
        var waterbody = settings.arguments as WaterBodyData;
        return MaterialPageRoute(builder: (_) => WaterBodyDataPage(waterbody));

      case nodeDetailRoute:
        var node = settings.arguments as Node;
        return MaterialPageRoute(builder: (_) => NodeDetailPage(node));
      case nodesShowRoute:
        return MaterialPageRoute(builder: (_) => NodesShowPage());
    }

    // if none of the cases matches
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}