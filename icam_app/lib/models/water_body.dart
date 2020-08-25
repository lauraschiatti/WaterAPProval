
// To parse this JSON data, do

//     final waterBody = waterBodyFromJson(jsonString);

//import 'dart:convert';
//
//import 'package:flutter/services.dart';
//
//List<WaterBody> waterBodyFromJson(String str) => List<WaterBody>.from(json.decode(str).map((x) => WaterBody.fromJson(x)));
//
//String waterBodyToJson(List<WaterBody> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//class WaterBody {
//  WaterBody({
//    this.id,
//    this.nodes,
//    this.type,
//    this.waterBodyId,
//    this.properties,
//    this.geometry,
//  });
//
//  String id;
//  List<String> nodes;
//  String type;
//  String waterBodyId;
//  Properties properties;
//  Geometry geometry;
//
//  factory WaterBody.fromJson(Map<String, dynamic> json) => WaterBody(
//    id: json["_id"],
//    nodes: List<String>.from(json["nodes"].map((x) => x)),
//    type: json["type"],
//    waterBodyId: json["id"],
//    properties: Properties.fromJson(json["properties"]),
//    geometry: Geometry.fromJson(json["geometry"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "_id": id,
//    "nodes": List<dynamic>.from(nodes.map((x) => x)),
//    "type": type,
//    "id": waterBodyId,
//    "properties": properties.toJson(),
//    "geometry": geometry.toJson(),
//  };
//}
//
//class Geometry {
//  Geometry({
//    this.type,
//    this.coordinates,
//  });
//
//  String type;
//  List<List<List<dynamic>>> coordinates;
//
//  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//    type: json["type"],
//    coordinates: List<List<List<dynamic>>>.from(json["coordinates"].map((x) => List<List<dynamic>>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "type": type,
//    "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
//  };
//}
//
//class Properties {
//  Properties({
//    this.name,
//    this.icam,
//  });
//
//  String name;
//  double icam;
//
//  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
//    name: json["name"],
//    icam: json["icam"].toDouble(),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "name": name,
//    "icam": icam,
//  };
//}

// mimics the behaviour of when we get the actual data from the API
//Future<List<WaterBody>> getNodeFromFakeServer() async {
//  String dataStr = await rootBundle
//      .loadString('assets/api_json/water_bodies.json');
//
//  return await Future.delayed(Duration(seconds: 2), (){
//    List<dynamic> data =  jsonDecode(dataStr);
//    List<WaterBody> waterBodies = data.map((data) =>
//        WaterBody.fromJson(data)
//    ).toList();
//    return waterBodies;
//  });
//}



// To parse this JSON data, do
//
//     final waterBody = waterBodyFromJson(jsonString);

import 'dart:convert';

WaterBody waterBodyFromJson(String str) => WaterBody.fromJson(json.decode(str));

String waterBodyToJson(WaterBody data) => json.encode(data.toJson());

class WaterBody {
  WaterBody({
    this.data,
    this.total,
  });

  List<Datum> data;
  int total;

  factory WaterBody.fromJson(Map<String, dynamic> json) => WaterBody(
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.category,
    this.name,
    this.description,
    this.form,
    this.user,
    this.active,
    this.puntosDeMonitoreo,
    this.icampff,
    this.trackedProperties,
    this.calculatedFields,
    this.date,
    this.icampffAvg,
    this.geojson,
    this.populatedForm,
    this.columns,
    this.sort,
  });

  String id;
  String category;
  String name;
  String description;
  String form;
  String user;
  bool active;
  List<String> puntosDeMonitoreo;
  int icampff;
  List<TrackedProperty> trackedProperties;
  List<CalculatedField> calculatedFields;
  int date;
  int icampffAvg;
  Geojson geojson;
  PopulatedForm populatedForm;
  List<dynamic> columns;
  String sort;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      category: json["category"],
      name: json["name"],
      description: json["description"],
      form: json["form"],
      user: json["user"],
      active: json["active"],
      puntosDeMonitoreo: List<String>.from(json["puntosDeMonitoreo"].map((x) => x)),
  icampff: json["icampff"],
  trackedProperties: List<TrackedProperty>.from(json["trackedProperties"].map((x) => trackedPropertyValues.map[x])),
  calculatedFields: List<CalculatedField>.from(json["calculatedFields"].map((x) => calculatedFieldValues.map[x])),
  date: json["date"],
  icampffAvg: json["icampffAvg"],
  geojson: Geojson.fromJson(json["geojson"]),
  populatedForm: json["populatedForm"] == null ? null : PopulatedForm.fromJson(json["populatedForm"]),
  columns: json["columns"] == null ? null : List<dynamic>.from(json["columns"].map((x) => x)),
  sort: json["sort"] == null ? null : json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "name": name,
    "description": description,
    "form": form,
    "user": user,
    "active": active,
    "puntosDeMonitoreo": List<dynamic>.from(puntosDeMonitoreo.map((x) => x)),
    "icampff": icampff,
    "trackedProperties": List<dynamic>.from(trackedProperties.map((x) => trackedPropertyValues.reverse[x])),
    "calculatedFields": List<dynamic>.from(calculatedFields.map((x) => calculatedFieldValues.reverse[x])),
    "date": date,
    "icampffAvg": icampffAvg,
    "geojson": geojson.toJson(),
    "populatedForm": populatedForm == null ? null : populatedForm.toJson(),
    "columns": columns == null ? null : List<dynamic>.from(columns.map((x) => x)),
    "sort": sort == null ? null : sort,
  };
}

enum CalculatedField { PUNTOS_DE_MONITOREO, ICA_MPFF, FECHA_DE_MEDICIN, GEO_JSON }

final calculatedFieldValues = EnumValues({
  "Fecha de medición": CalculatedField.FECHA_DE_MEDICIN,
  "GeoJSON": CalculatedField.GEO_JSON,
  "ICAMpff": CalculatedField.ICA_MPFF,
  "Puntos de Monitoreo": CalculatedField.PUNTOS_DE_MONITOREO
});

class Geojson {
  Geojson({
    this.type,
    this.properties,
    this.geometry,
    this.id,
  });

  String type;
  Properties properties;
  Geometry geometry;
  String id;

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
    type: json["type"],
    properties: Properties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties.toJson(),
    "geometry": geometry.toJson(),
    "id": id == null ? null : id,
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
    icam: json["icam"] == null ? null : json["icam"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icam": icam == null ? null : icam,
  };
}

class PopulatedForm {
  PopulatedForm({
    this.id,
    this.category,
    this.name,
    this.description,
    this.user,
    this.fields,
    this.active,
  });

  String id;
  String category;
  String name;
  String description;
  String user;
  List<Field> fields;
  bool active;

  factory PopulatedForm.fromJson(Map<String, dynamic> json) => PopulatedForm(
      id: json["id"],
      category: json["category"],
      name: json["name"],
      description: json["description"],
      user: json["user"],
      fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "name": name,
    "description": description,
    "user": user,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
    "active": active,
  };
}

class Field {
  Field({
    this.type,
    this.validators,
    this.required,
    this.readOnly,
    this.hidden,
    this.name,
    this.title,
    this.description,
    this.defaultValue,
    this.form,
    this.multi,
    this.populate,
    this.format,
  });

  Type type;
  List<dynamic> validators;
  bool required;
  bool readOnly;
  bool hidden;
  TrackedProperty name;
  CalculatedField title;
  String description;
  dynamic defaultValue;
  String form;
  bool multi;
  bool populate;
  String format;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
      type: typeValues.map[json["type"]],
      validators: List<dynamic>.from(json["validators"].map((x) => x)),
  required: json["required"],
  readOnly: json["readOnly"],
  hidden: json["hidden"],
  name: trackedPropertyValues.map[json["name"]],
  title: calculatedFieldValues.map[json["title"]],
  description: json["description"],
  defaultValue: json["defaultValue"],
  form: json["form"] == null ? null : json["form"],
  multi: json["multi"] == null ? null : json["multi"],
  populate: json["populate"] == null ? null : json["populate"],
  format: json["format"] == null ? null : json["format"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "validators": List<dynamic>.from(validators.map((x) => x)),
    "required": required,
    "readOnly": readOnly,
    "hidden": hidden,
    "name": trackedPropertyValues.reverse[name],
    "title": calculatedFieldValues.reverse[title],
    "description": description,
    "defaultValue": defaultValue,
    "form": form == null ? null : form,
    "multi": multi == null ? null : multi,
    "populate": populate == null ? null : populate,
    "format": format == null ? null : format,
  };
}

enum TrackedProperty { ICAMPFF_AVG, DATE, PUNTOS_DE_MONITOREO, GEOJSON }

final trackedPropertyValues = EnumValues({
  "date": TrackedProperty.DATE,
  "geojson": TrackedProperty.GEOJSON,
  "icampffAvg": TrackedProperty.ICAMPFF_AVG,
  "puntosDeMonitoreo": TrackedProperty.PUNTOS_DE_MONITOREO
});

enum Type { TRACKED_OBJECT, NUMBER, DATE, FILE }

final typeValues = EnumValues({
  "date": Type.DATE,
  "file": Type.FILE,
  "number": Type.NUMBER,
  "tracked-object": Type.TRACKED_OBJECT
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

