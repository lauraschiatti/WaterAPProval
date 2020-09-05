// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.id,
    this.name,
    this.separator,
    this.sensors,
  });

  String id;
  String name;
  String separator;
  List<Sensor> sensors;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
      id: json["_id"],
      name: json["name"],
      separator: json["separator"],
      sensors: List<Sensor>.from(json["sensors"].map((x) => Sensor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "separator": separator,
    "sensors": List<dynamic>.from(sensors.map((x) => x.toJson())),
  };
}

class Sensor {
  Sensor({
    this.variable,
    this.description,
    this.unit,
  });

  String variable;
  String description;
  String unit;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
    variable: json["variable"],
    description: json["description"] == null ? null : json["description"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "variable": variable,
    "description": description == null ? null : description,
    "unit": unit,
  };
}
