import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/services/nodes_db_provider.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/localization/localization_constants.dart';


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

  // get all favorite nodes
  _getNodes() async {
    final _nodeData = await DBProvider.db.getNodes();
    return _nodeData;
  }

  // get nodes filtered by name
  _getFilteredNodes(name) async {
    final _nodeData = await DBProvider.db.getNodesByName(name);
    print("_nodeData: $_nodeData");
    return _nodeData;
  }


  void updateNodes(String name) {
    print("search text: $name");

    setState(() {
      _nodeFuture = _getFilteredNodes(name);
    });
  }

  List<Node> nodes;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            //  hide the soft keyboard clicking anywhere on the screen.
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: FutureBuilder(
              future: _nodeFuture,
              builder: (context, snapshot) {

//            if (snapshot.hasError) {
////           if (snapshot.hasError) {
//              children = <Widget>[
//                Icon(
//                  Icons.error_outline,
//                  color: Colors.red,
//                  size: 60,
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 16),
//                  child: Text('Error: ${snapshot.error}'),
//                )
//              ];
//            }

                if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      padding: EdgeInsets.all(14),
                      child: Text(getTranslated(context, "no_nodes"))
                  );
                }

                if (snapshot.hasData) {
                  nodes = snapshot.data;

                  return Container(
                    padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                    _buildRichText(),
                        _buildTextField(),
                        Expanded(
//              child: RefreshIndicator(
//                onRefresh: refreshList,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: nodes.length,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              itemBuilder: (BuildContext cnt, int index) {
                                final Node node = nodes[index];

                                return Card(
                                    elevation: 18.0,
                                    shadowColor: Colors.black12,
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15
                                        ),
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
                                            fontSize: 11,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.black38,
                                          onPressed: () {
                                            DBProvider.db.deleteNode(node.id);

                                            setState(() {
                                              nodes.removeAt(index);
                                            });
                                          },
                                        )
                                    )
                                );
                              },
                            )
                        ),
                      ],
                    ),
                  );
                }


                return Center(
                  child: Container(
                    child: new CircularProgressIndicator(),
                  ),
                );
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_location, color: Colors.white),
          backgroundColor: myTheme.primaryColor,
          onPressed: () async {
            Navigator.pushNamed(context, nodesShowRoute);
//              .then((val)=>{_getNodes()});

//          Navigator.pushNamed(context, nodesShowRoute)
//              .then((value) {
//                setState(() {
//                  // refresh state of Page1
//                  _getNodes();
//                });
//              });
          }
      ),
    );
  }

  _buildRichText() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
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
                TextSpan(text: '       ${nodes.length}',
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
    );
  }

  _buildTextField() {

    return Container(
        padding: EdgeInsets.all(15),
        child: CupertinoTextField(
          controller: _controller,
          onChanged: updateNodes,
          prefix: Icon(
            CupertinoIcons.search,
            size: 28,
            color: Colors.black54,
          ),
          suffix: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(Icons.clear),
            color: myTheme.primaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0,
                    color: CupertinoColors.inactiveGray
                )
            ),
          ),
          placeholder: getTranslated(context, "search_fav_nodes") + " (${nodes.length})",
        )
    );
  }

}