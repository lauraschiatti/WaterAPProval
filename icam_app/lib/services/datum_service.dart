import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:icam_app/models/datum.dart';


fetchData(String additionalFilters) async {
  final query = 'this.data';
  final endpoint = 'https://aquapp.utb.edu.co/api/v1/data/open/vm2';

  var response = await http.get(endpoint + "?query=" + query + "&additionalFilters=" + additionalFilters);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    String source = Utf8Decoder().convert(response.bodyBytes);

    return datumFromJson(source);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}