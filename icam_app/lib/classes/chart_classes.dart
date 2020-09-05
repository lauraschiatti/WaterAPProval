class Unit{
  String name;
  String unit;

  Unit(this.name, this.unit);

  String get getName {
    return name;
  }

  String get getUnit {
    return unit;
  }

  @override
  String toString() {
    return "Unit [name=${this.name},unit=${this.unit}]";
  }

}

class SensorAxis {
  String name;
  String title;

  // constructor with syntactic sugar
  SensorAxis(this.name, this.title);
}

class ChartAxis {
  String id;
  String name;
  String type;
  bool active;
  bool dataLoaded;
  List data;
  List<SensorAxis> sensors;
  List<String> activeSensors;

  ChartAxis(this.id, this.name, this.type, this.active, this.dataLoaded, this.data);

//  @override
//  String toString() {
//    return "Axis [id=${this.id},name=${this.name},type=${this.type}"
//        ",active=${this.active},dataLoaded=${this.dataLoaded},sensors=${this.sensors}"
//        ",activeSensors=${this.activeSensors}]";
//  }
}

class WQMonitoringPointAxis implements ChartAxis {

  @override
  String id;
  @override
  String name;
  @override
  String type;
  @override
  bool active;
  @override
  bool dataLoaded;
  @override
  List data = [];

  @override
  List<SensorAxis> sensors = [
    new SensorAxis('icampff', 'ICAMpff'),
    new SensorAxis('dissolvedOxygen', 'Oxígeno disuelto'),
    new SensorAxis('nitrate', 'Nitratos'),
    new SensorAxis('totalSuspendedSolids', 'Sólidos suspendidos totales'),
    new SensorAxis('thermotolerantColiforms', 'Coliformes termotolerantes'),
    new SensorAxis('thermotolerantColiforms', 'Coliformes termotolerantes'),
    new SensorAxis('pH', 'pH'),
    new SensorAxis('chrolophyllA', 'Clorofila A'),
    new SensorAxis('biochemicalOxygenDemand', 'Demanda bioquímica de oxígeno'),
    new SensorAxis('phosphates', 'Fosfatos')
  ];

  @override
  List<String> activeSensors = [];

//  WQMonitoringPointAxis(id, name, type, active, dataLoaded, data, this._sensors, this._activeSensors)
//      : super(id, name, type, active, dataLoaded, data);

  @override
  String toString() {
    return "WQMonitoringPointAxis [id=${this.id},name=${this.name},type=${this.type}"
        ",active=${this.active},dataLoaded=${this.dataLoaded},data=${this.data}"
        ",sensors=${this.sensors},activeSensors=${this.activeSensors}]";
  }
}

class WaterBodyAxis implements ChartAxis {

  @override
  String id;
  @override
  String name;
  @override
  String type;
  @override
  bool active;
  @override
  bool dataLoaded;
  @override
  List data = [];

  @override
  List<SensorAxis> sensors = [
    SensorAxis('icampff', 'ICAMpff')
  ];

  @override
  List<String> activeSensors = ['icampff'];

  @override
  String toString() {
    return "WaterBodyAxis [id=${this.id},name=${this.name},type=${this.type}"
        ",active=${this.active},dataLoaded=${this.dataLoaded},data=${this.data}"
        ",sensors=${this.sensors},activeSensors=${this.activeSensors}]";
  }

}