import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/models/water_body.dart';
import 'package:icam_app/ui/about.dart';
import 'package:icam_app/ui/export_page.dart';
import 'package:icam_app/ui/encyclopedia_page.dart';
import 'package:icam_app/ui/nodes/nodes_show.dart';
import 'package:icam_app/ui/settings.dart';
import 'package:icam_app/ui/home_page.dart';
import 'package:icam_app/ui/map_page.dart';
import 'package:icam_app/ui/cartagena.dart';
import 'package:icam_app/ui/not_found.dart';
import 'package:icam_app/ui/nodes/node_details.dart';
import 'package:icam_app/ui/water_body_data_page.dart';
import 'package:icam_app/ui/calculator.dart';
import 'package:icam_app/ui/explore_data.dart';
import 'package:icam_app/ui/water_bodies/water_bodies_details.dart';
import 'package:icam_app/ui/dashboard.dart';

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
      case exploreRoute:
        return MaterialPageRoute(builder: (_) => ExploreDataPage());

      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => DashboardPage());

      case encyclopediaRoute:
        return MaterialPageRoute(builder: (_) => EncyclopediaPage());
      case calculatorRoute:
        return MaterialPageRoute(builder: (_) => CalculatorPage());

      case waterBodyDataPageRoute:
        var waterbody = settings.arguments as WaterBodyData;
        return MaterialPageRoute(builder: (_) => WaterBodyDataPage(waterbody));
      case waterBodyDetailPageRoute:
        var waterbody = settings.arguments as WaterBodyData;
        return MaterialPageRoute(builder: (_) => WaterBodyDetailPage(waterbody));

      case nodeDetailRoute:
        var node = settings.arguments as Node;
        return MaterialPageRoute(builder: (_) => NodeDetailPage(node));
      case nodesShowRoute:
        return MaterialPageRoute(builder: (_) =>  NodesShowPage());
    }

    // if none of the cases matches
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}