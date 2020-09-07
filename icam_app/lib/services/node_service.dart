import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:icam_app/models/node_server.dart';


fetchNodes() async {
  final endpoint = 'https://aquapp.utb.edu.co/api/v1/elements/open/jsonata';

  final query = "([\$])";
  var additionalFilters = '[{"category":"tracked-objects"},{"form":"5dacb798a52adb394573ca70"}]';

  var response = await http.get(endpoint + "?query=" + query
      + "&additionalFilters=" + additionalFilters);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    String source = Utf8Decoder().convert(response.bodyBytes);
    return nodeFromJson(source);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load node');
  }
}