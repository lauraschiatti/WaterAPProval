
import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/services/nodes_db_provider.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return Scaffold(
      appBar: new AppBar(
        title: Text('${widget.node.name}'),
      ),

      body: FutureBuilder(
          future: _nodeFuture,
          builder: (context, snapshot){

            IconButton favorite;
//            Icon icon = Icon(Icons.favorite);

            if (snapshot.hasData) {
              favorite = IconButton(
                icon: Icon(Icons.favorite), //icon
                color: Colors.red,
                onPressed: (){ // delete from favorite
                  print("favorite");
                  DBProvider.db.deleteNode(widget.node.id);

                  setState(() {
//                    icon = Icon(Icons.play_arrow); #TODO: change icon
                  });
                },
              );
            } else{
              favorite = IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: (){  // add to favorite
                  print("non favorite");
                  DBProvider.db.insertNode(widget.node);

                  setState(() {
//                    new Icon(Icons.play_arrow);
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
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              favorite
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            child: Text('Location: ${widget.node.location}',
                                style: new TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            child: Text('Status: ${widget.node.status}',
                                style: new TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            child: Text(
                                'LAT: ${widget.node.coordinates[0]} '
                                    'LON: ${widget.node.coordinates[1]}',
                                style: new TextStyle(fontSize: 16.0)),
                          ),
                          // @TODO: nodeTypeId
                        ],
                      )
                    ],
                  ),
                ),

              ],
            );

          }
      ),
//      body: Stack(
//        children: <Widget>[
//          new Container(
//            padding: new EdgeInsets.all(20.0),
//            child: new Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                new Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Container(
//                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                      child: Text('Location: ${widget.node.location}',
//                          style: new TextStyle(fontSize: 16.0)),
//                    ),
//                    Container(
//                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                      child: Text('Status: ${widget.node.status}',
//                          style: new TextStyle(fontSize: 16.0)),
//                    ),
//                    Container(
//                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                      child: Text(
//                          'LAT: ${widget.node.coordinates[0]} LON: ${widget.node.coordinates[1]}',
//                          style: new TextStyle(fontSize: 16.0)),
//                    ),
//                    // @TODO: nodeTypeId
//
//                  ],
//                )
//              ],
//            ),
//          ),
//
//        ],
//      )
    );
  }
}