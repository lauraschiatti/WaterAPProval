import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:icam_app/models/datum.dart';


fetchData(String additionalFilters) async {
  final query = 'this.data';
  final endpoint = 'https://aquapp.utb.edu.co/api/v1/data/open/vm2';

  //https://aquapp.utb.edu.co/api/v1/data/open/vm2?query=this.data&additionalFilters=
  // [{"trackedObject": {"inq": ["5dacbdcaa52adb394573ca71","5db298ae458f3171dfaf380c","5db3cb23a53e2a1083580729",
  // "5db3cb31a53e2a108358072a","5db4b2a9327b7d19875b3bc2","5db4b2ae327b7d19875b3bc3","5db4f025b5986235dfe6600e",
  // "5db4f024b5986235dfe6600d"]}}] ==> 8 nodes
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