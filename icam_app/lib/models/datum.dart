// To parse this JSON data, do
//
//     final datum = datumFromJson(jsonString);

import 'dart:convert';

List<Datum> datumFromJson(String str) => List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));

String datumToJson(List<Datum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datum {
  Datum({
    this.id,
    this.sensor,
    this.trackedObject,
    this.user,
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
    this.active,
    this.createdAt,
  });

  String id;
  String sensor;
  String trackedObject;
  String user;
  int latitude;
  int longitude;
  double icampff;
  double dissolvedOxygen;
  double nitrate;
  double totalSuspendedSolids;
  double thermotolerantColiforms;
  double pH;
  double chrolophyllA;
  double biochemicalOxygenDemand;
  double phosphates;
  int date;
  bool active;
  int createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sensor: json["sensor"],
    trackedObject: json["trackedObject"],
    user: json["user"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    icampff: json["icampff"].toDouble(),
    dissolvedOxygen: json["dissolvedOxygen"].toDouble(),
    nitrate: json["nitrate"].toDouble(),
    totalSuspendedSolids: json["totalSuspendedSolids"].toDouble(),
    thermotolerantColiforms: json["thermotolerantColiforms"].toDouble(),
    pH: json["pH"].toDouble(),
    chrolophyllA: json["chrolophyllA"].toDouble(),
    biochemicalOxygenDemand: json["biochemicalOxygenDemand"].toDouble(),
    phosphates: json["phosphates"].toDouble(),
    date: json["date"],
    active: json["active"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sensor": sensor,
    "trackedObject": trackedObject,
    "user": user,
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
    "active": active,
    "createdAt": createdAt,
  };
}
