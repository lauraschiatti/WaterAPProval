import 'package:flutter/material.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/services/db_provider.dart';
import 'package:icam_app/models/node.dart';

class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  // to avoid re-running the build method
  Future _nodeFuture;

  @override
  void initState() {
    super.initState();
    _nodeFuture = _getNodes();
  }

  _getNodes() async{
    final _nodeData  = await DBProvider.db.getNodes();
    return _nodeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _nodeFuture,
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return ListViewNodes(nodes: snapshot.data);
            }

            if(snapshot.data == null || snapshot.data.length == 0){
              Text("No Data Found");
            }

            return  Center(
              child: Container(
                child: new CircularProgressIndicator(),
              ),
            );

          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location, color: Colors.white),
        backgroundColor: myTheme.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, nodesShowRoute);
          setState(() {});
        }
      ),
    );
  }
}

class ListViewNodes extends StatefulWidget {
  final List<Node> nodes;


  ListViewNodes({Key key, this.nodes}) : super(key: key);

  @override
  _ListViewNodesState createState() => _ListViewNodesState();
}

class _ListViewNodesState extends State<ListViewNodes> {

  @override
  Widget build(BuildContext context) {

    return Container(
//      padding: EdgeInsets.fromLTRB(
//        16,
//        kToolbarHeight - 20.0,
//        16,
//        16,
//      ),
      padding: EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'My favorite nodes',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '       ${widget.nodes.length}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Colors.black38
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 10),
          Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.nodes.length,
//                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                itemBuilder: (BuildContext cnt, int index) {

                  final Node node = widget.nodes[index];

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    title: Text(node.name,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    subtitle: Text(
                      node.location,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          DBProvider.db.deleteNode(node.id);

                          setState(() {
                            widget.nodes.removeAt(index);
                          });
                        },
                    ),
//                    onTap: () {
//                      setState(() {
//                        if (alreadySaved) {
//                          _saved.remove(node);
//                          DBProvider.db.deleteNode(node.id);
//                        } else {
//                          _saved.add(node);
//                          DBProvider.db.insertNode(node);
//                        }
//                      });

//                      print("_saved: $_saved");
//                    },
                  );
                },
              )
          )

        ],
      ),
    );
  }
}