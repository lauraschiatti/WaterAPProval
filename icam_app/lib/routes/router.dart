import 'package:flutter/material.dart';
import 'package:icam_app/src/info.dart';
import 'package:icam_app/src/home_page.dart';
import 'package:icam_app/src/map_page.dart';
import 'package:icam_app/src/not_found.dart';

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
      case infoRoute:
        return MaterialPageRoute(builder: (_) => InfoPage());
    }

    // if none of the cases matches
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}