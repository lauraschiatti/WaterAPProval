// To parse this JSON data, do
//
//     final node = nodeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/services.dart';

// JSON conversion methods
List<Node> nodeFromJson(String str) => List<Node>.from(json.decode(str).map((x) => Node.fromJson(x)));

String nodeToJson(List<Node> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Node {
  Node({
    this.id,
    this.name,
    this.location,
    this.coordinates,
    this.status,
    this.nodeTypeId,
  });

  String id;
  String name;
  String location;
  List<double> coordinates;
  String status;
  NodeTypeId nodeTypeId;

  // get a map string dynamic and and convert it into an
  // instance of Node
  factory Node.fromJson(Map<String, dynamic> json) => Node(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    status: json["status"] == null ? null : json["status"],
    nodeTypeId: nodeTypeIdValues.map[json["node_type_id"]],
  );

  // convert Node instance into map string dynamic
  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "status": status == null ? null : status,
    "node_type_id": nodeTypeIdValues.reverse[nodeTypeId],
  };
}

enum NodeTypeId { THE_59_C9_D9019_A892016_CA4_BE413, THE_5_A16342_A9_A8920290056_A542, THE_59_C9_D9019_A892016_CA4_BE412 }

final nodeTypeIdValues = EnumValues({
  "59c9d9019a892016ca4be412": NodeTypeId.THE_59_C9_D9019_A892016_CA4_BE412,
  "59c9d9019a892016ca4be413": NodeTypeId.THE_59_C9_D9019_A892016_CA4_BE413,
  "5a16342a9a8920290056a542": NodeTypeId.THE_5_A16342_A9_A8920290056_A542
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

// mimics the behaviour of when we get the actual data from the API
Future<List<Node>> getNodeFromFakeServer() async {
  String dataStr = await rootBundle.loadString('assets/api_json/nodes.json');

  return await Future.delayed(Duration(seconds: 2), (){
      List<dynamic> data =  jsonDecode(dataStr);
      List<Node> nodes = data.map((data) => Node.fromJson(data)).toList();
      return nodes;
  });
}


//  Future<Locations> getGoogleOffices() async {
//    const googleLocationsURL = 'https://about.google/static/data/locations.json';
//
//    // Retrieve the locations of Google offices
//    final response = await http.get(googleLocationsURL);
//    if (response.statusCode == 200) {
//      return Locations.fromJson(json.decode(response.body));
//    } else {
//      throw HttpException(
//          'Unexpected status code ${response.statusCode}:'
//              ' ${response.reasonPhrase}',
//          uri: Uri.parse(googleLocationsURL));
//    }
//  }


