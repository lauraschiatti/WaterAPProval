
// To parse this JSON data, do

//     final waterBody = waterBodyFromJson(jsonString);
import 'dart:convert';

import 'package:flutter/services.dart';

List<WaterBody> waterBodyFromJson(String str) => List<WaterBody>.from(json.decode(str).map((x) => WaterBody.fromJson(x)));

String waterBodyToJson(List<WaterBody> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WaterBody {
  WaterBody({
    this.id,
    this.nodes,
    this.type,
    this.waterBodyId,
    this.properties,
    this.geometry,
  });

  String id;
  List<String> nodes;
  String type;
  String waterBodyId;
  Properties properties;
  Geometry geometry;

  factory WaterBody.fromJson(Map<String, dynamic> json) => WaterBody(
    id: json["_id"],
    nodes: List<String>.from(json["nodes"].map((x) => x)),
    type: json["type"],
    waterBodyId: json["id"],
    properties: Properties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nodes": List<dynamic>.from(nodes.map((x) => x)),
    "type": type,
    "id": waterBodyId,
    "properties": properties.toJson(),
    "geometry": geometry.toJson(),
  };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String type;
  List<List<List<dynamic>>> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: json["type"],
    coordinates: List<List<List<dynamic>>>.from(json["coordinates"].map((x) => List<List<dynamic>>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}

class Properties {
  Properties({
    this.name,
    this.icam,
  });

  String name;
  double icam;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    name: json["name"],
    icam: json["icam"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icam": icam,
  };
}

// mimics the behaviour of when we get the actual data from the API
Future<List<WaterBody>> getNodeFromFakeServer() async {
  String dataStr = await rootBundle
      .loadString('assets/api_json/water_bodies.json');

  return await Future.delayed(Duration(seconds: 2), (){
    List<dynamic> data =  jsonDecode(dataStr);
    List<WaterBody> water_bodies = data.map((data) =>
        WaterBody.fromJson(data)
    ).toList();
    return water_bodies;
  });
}

