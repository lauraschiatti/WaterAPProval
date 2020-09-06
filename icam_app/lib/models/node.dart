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
    this.lastDatum,
  });

  String id;
  String name;
  String location;
  List<double> coordinates;
  String status;
  LastDatum lastDatum;

  // status: Off, Non Real Time

  // get a map string dynamic and and convert it into an
  // instance of Node
  factory Node.fromJson(Map<String, dynamic> json) => Node(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    status: json["status"] == null ? null : json["status"],
    lastDatum: LastDatum.fromJson(json["lastDatum"]),
  );

  // convert Node instance into map string dynamic
  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    // flatten the model to consider supported types for sqlite.
//    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "status": status,
//    "lastDatum": lastDatum.toJson(),
  };
}

class LastDatum {
  LastDatum({
    this.latitude,
    this.longitude,
    this.icampff,
    this.dissolvedOxygen,
    this.nitrate,
    this.totalSuspendedSolids,
    this.thermotolerantColiforms,
    this.pH,
    this.chrolophyllA,
    this.biochemicalOxygenDemand,
    this.phosphates,
    this.date,
    this.trackedObject,
    this.active,
    this.createdAt,
    this.sensor,
    this.user,
  });

  int latitude;
  int longitude;
  double icampff;
  double dissolvedOxygen;
  double nitrate;
  double totalSuspendedSolids;
  int thermotolerantColiforms;
  double pH;
  double chrolophyllA;
  double biochemicalOxygenDemand;
  double phosphates;
  dynamic date;
  String trackedObject;
  bool active;
  int createdAt;
  String sensor;
  String user;

  factory LastDatum.fromJson(Map<String, dynamic> json) => LastDatum(
    latitude: json["latitude"],
    longitude: json["longitude"],
    icampff: json["icampff"].toDouble(),
    dissolvedOxygen: json["dissolvedOxygen"].toDouble(),
    nitrate: json["nitrate"].toDouble(),
    totalSuspendedSolids: json["totalSuspendedSolids"].toDouble(),
    thermotolerantColiforms: json["thermotolerantColiforms"],
    pH: json["pH"].toDouble(),
    chrolophyllA: json["chrolophyllA"].toDouble(),
    biochemicalOxygenDemand: json["biochemicalOxygenDemand"].toDouble(),
    phosphates: json["phosphates"].toDouble(),
    date: json["date"],
    trackedObject: json["trackedObject"],
    active: json["active"],
    createdAt: json["createdAt"],
    sensor: json["sensor"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "icampff": icampff,
    "dissolvedOxygen": dissolvedOxygen,
    "nitrate": nitrate,
    "totalSuspendedSolids": totalSuspendedSolids,
    "thermotolerantColiforms": thermotolerantColiforms,
    "pH": pH,
    "chrolophyllA": chrolophyllA,
    "biochemicalOxygenDemand": biochemicalOxygenDemand,
    "phosphates": phosphates,
    "date": date,
    "trackedObject": trackedObject,
    "active": active,
    "createdAt": createdAt,
    "sensor": sensor,
    "user": user,
  };
}

// mimics the behaviour of when we get the actual data from the API
//Future<List<Node>>
getNodeFromFakeServer() async {
  String dataStr = await rootBundle
      .loadString('assets/api_json/nodes.json');

  return await Future.delayed(Duration(seconds: 2), (){
      List<dynamic> data =  jsonDecode(dataStr);
      List<Node> nodes = data.map((data) =>
          Node.fromJson(data)
      ).toList();

      return nodes;

  });

}