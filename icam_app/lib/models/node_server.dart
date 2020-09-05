
// To parse this JSON data, do
//
//     final node = nodeFromJson(jsonString);

import 'dart:convert';

Node nodeFromJson(String str) => Node.fromJson(json.decode(str));

String nodeToJson(Node data) => json.encode(data.toJson());

class Node {
  Node({
    this.data,
    this.total,
  });

  List<NodeData> data;
  int total;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
      data: List<NodeData>.from(json["data"].map((x) => NodeData.fromJson(x))),
      total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
  };
}

class NodeData {
  NodeData({
    this.id,
    this.category,
    this.name,
    this.description,
    this.form,
    this.user,
    this.active,
    this.biochemicalOxygenDemand,
    this.calculatedFields,
    this.chrolophyllA,
    this.dissolvedOxygen,
    this.icampff,
    this.latitude,
    this.longitude,
    this.nitrate,
    this.pH,
    this.phosphates,
    this.thermotolerantColiforms,
    this.totalSuspendedSolids,
    this.trackedProperties,
    this.lastDatum,
    this.date,
    this.columns,
    this.sort,
    this.populatedForm,
  });

  String id;
  String category;
  String name;
  String description;
  String form;
  String user;
  bool active;
  int biochemicalOxygenDemand;
  List<String> calculatedFields;
  int chrolophyllA;
  int dissolvedOxygen;
  int icampff;
  double latitude;
  double longitude;
  int nitrate;
  int pH;
  int phosphates;
  int thermotolerantColiforms;
  int totalSuspendedSolids;
  List<String> trackedProperties;
  LastDatum lastDatum;
  int date;
  List<Sort> columns;
  Sort sort;
  PopulatedForm populatedForm;

  factory NodeData.fromJson(Map<String, dynamic> json) => NodeData(
      id: json["id"],
      category: json["category"],
      name: json["name"],
      description: json["description"],
      form: json["form"],
      user: json["user"],
      active: json["active"],
      biochemicalOxygenDemand: json["biochemicalOxygenDemand"],
      calculatedFields: List<String>.from(json["calculatedFields"].map((x) => x)),
  chrolophyllA: json["chrolophyllA"],
  dissolvedOxygen: json["dissolvedOxygen"],
  icampff: json["icampff"],
  latitude: json["latitude"].toDouble(),
  longitude: json["longitude"].toDouble(),
  nitrate: json["nitrate"],
  pH: json["pH"],
  phosphates: json["phosphates"],
  thermotolerantColiforms: json["thermotolerantColiforms"],
  totalSuspendedSolids: json["totalSuspendedSolids"],
  trackedProperties: List<String>.from(json["trackedProperties"].map((x) => x)),
  lastDatum: LastDatum.fromJson(json["lastDatum"]),
  date: json["date"],
  columns: List<Sort>.from(json["columns"].map((x) => sortValues.map[x])),
  sort: sortValues.map[json["sort"]],
  populatedForm: json["populatedForm"] == null ? null : PopulatedForm.fromJson(json["populatedForm"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "name": name,
    "description": description,
    "form": form,
    "user": user,
    "active": active,
    "biochemicalOxygenDemand": biochemicalOxygenDemand,
    "calculatedFields": List<dynamic>.from(calculatedFields.map((x) => x)),
    "chrolophyllA": chrolophyllA,
    "dissolvedOxygen": dissolvedOxygen,
    "icampff": icampff,
    "latitude": latitude,
    "longitude": longitude,
    "nitrate": nitrate,
    "pH": pH,
    "phosphates": phosphates,
    "thermotolerantColiforms": thermotolerantColiforms,
    "totalSuspendedSolids": totalSuspendedSolids,
    "trackedProperties": List<dynamic>.from(trackedProperties.map((x) => x)),
    "lastDatum": lastDatum.toJson(),
    "date": date,
    "columns": List<dynamic>.from(columns.map((x) => sortValues.reverse[x])),
    "sort": sortValues.reverse[sort],
    "populatedForm": populatedForm == null ? null : populatedForm.toJson(),
  };
}

enum Sort { ICAMPFF, DATE }

final sortValues = EnumValues({
  "date": Sort.DATE,
  "icampff": Sort.ICAMPFF
});

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
  });

  Type type;
  List<Validator> validators;
  bool required;
  bool readOnly;
  bool hidden;
  String name;
  String title;
  String description;
  dynamic defaultValue;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
      type: typeValues.map[json["type"]],
      validators: List<Validator>.from(json["validators"].map((x) => validatorValues.map[x])),
  required: json["required"] == null ? null : json["required"],
  readOnly: json["readOnly"] == null ? null : json["readOnly"],
  hidden: json["hidden"] == null ? null : json["hidden"],
  name: json["name"],
  title: json["title"],
  description: json["description"],
  defaultValue: json["defaultValue"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "validators": List<dynamic>.from(validators.map((x) => validatorValues.reverse[x])),
    "required": required == null ? null : required,
    "readOnly": readOnly == null ? null : readOnly,
    "hidden": hidden == null ? null : hidden,
    "name": name,
    "title": title,
    "description": description,
    "defaultValue": defaultValue,
  };
}

enum Type { NUMBER, DATE }

final typeValues = EnumValues({
  "date": Type.DATE,
  "number": Type.NUMBER
});

enum Validator { LATITUDE, LONGITUDE }

final validatorValues = EnumValues({
  "latitude": Validator.LATITUDE,
  "longitude": Validator.LONGITUDE
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
