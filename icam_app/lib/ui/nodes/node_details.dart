
import 'package:flutter/material.dart';
import 'package:icam_app/classes/utils.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/services/nodes_db_provider.dart';

class NodeDetailPage extends StatefulWidget {

  final Node node;
  NodeDetailPage(this.node);

  @override
  _NodeDetailPageState createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends State<NodeDetailPage> {

  // to avoid re-running the build method
  Future _nodeFuture;


  @override
  void initState() {
    super.initState();
    _nodeFuture = _getNode();
  }

  _getNode() async{
    final _nodeData  = await DBProvider.db.getNode(widget.node.id);
    return _nodeData;
  }

  @override
  Widget build(BuildContext context) {

    TextStyle titleStyle = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Scaffold(
      appBar: new AppBar(
        title: Text('${widget.node.name}'),
      ),

      body: FutureBuilder(
          future: _nodeFuture,
          builder: (context, snapshot){

            IconButton favorite;
            Icon icon;
            if (snapshot.hasData) {
              icon = Icon(Icons.favorite);
            } else {
              icon = Icon(Icons.favorite_border);
            }


            if (snapshot.hasData) {
              favorite = IconButton(
                icon: icon, //icon
                color: Colors.red,
                onPressed: (){ // delete from favorite
                  print("favorite");
                  DBProvider.db.deleteNode(widget.node.id);

                  setState(() {
                    icon = Icon(Icons.play_arrow);
                  });
                },
              );
            } else{
              favorite = IconButton(
                icon: icon,
                color: Colors.red,
                onPressed: (){  // add to favorite
                  print("non favorite");
                  DBProvider.db.insertNode(widget.node);

                  setState(() {
                    icon = Icon(Icons.play_arrow);
                  });
                },
              );
            }

            return Stack(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
//                              favorite,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  getTranslated(context, "mp_info"),
                                  style: titleStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.my_location),
                                        title: Text(getTranslated(context, "node_status")),
                                        subtitle: Text("${widget.node.status}"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on),
                                        title: Text(getTranslated(context, "node_location")),
                                        subtitle: Text("${widget.node.location}"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text(getTranslated(context, "node_coordinates")),
                                        subtitle: Text("LAT: ${widget.node.coordinates[0]}, \n"
                                            "LON: ${widget.node.coordinates[1]}"),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  getTranslated(context, "last_datum") + " ${readTimestamp(widget.node.lastDatum.date)[0].toString()}",
                                  style: titleStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(getTranslated(context, "dissolved_oxygen") + ": ${widget.node.lastDatum.dissolvedOxygen.toString()}"),
                                  Text(getTranslated(context, "nitrate") + ": ${widget.node.lastDatum.nitrate.toString()}"),
                                  Text(getTranslated(context, "total_suspended_solids") + ": ${widget.node.lastDatum.totalSuspendedSolids.toString()}"),
                                  Text(getTranslated(context, "thermotolerant_coliforms") + ": ${widget.node.lastDatum.thermotolerantColiforms.toString()}"),
                                  Text(getTranslated(context, "ph") + ": ${widget.node.lastDatum.pH.toString()}"),
                                  Text(getTranslated(context, "chrolophyll_a") + ": ${widget.node.lastDatum.chrolophyllA.toString()}"),
                                  Text(getTranslated(context, "biochemical_oxygen_demand") + ": ${widget.node.lastDatum.biochemicalOxygenDemand.toString()}"),
                                  Text(getTranslated(context, "phosphates") + ": ${widget.node.lastDatum.phosphates.toString()}"),
                                  Text(getTranslated(context, "obtained_icampff") + ": ${widget.node.lastDatum.icampff.toString()}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

          }
      ),
    );
  }
}


