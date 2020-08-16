import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/services/db_provider.dart';
import 'package:icam_app/theme.dart';

import 'dart:convert';


class NodesShowPage extends StatefulWidget {

  @override
  _NodesShowPageState createState() => _NodesShowPageState();

//  void onLoad(BuildContext context){
//    dynamic nodes = node.getNodeFromFakeServer();
//  }

}

class _NodesShowPageState extends State<NodesShowPage> {

  List nodes = [];

  void updateNodes(String search) {
    getNodeFromFakeServer().then((n) =>
        setState(() {
          nodes = n;
        })
    );
  }

  final _saved = Set<Node>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Available Nodes"),
          actions: <Widget>[
//            IconButton(icon: Icon(Icons.clear), onPressed: () {}),
//            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
          ],
//          actions: <Widget>[
//            IconButton(onPressed: (){
//              showSearch(context: context, delegate: NodeItemsSearch());
//            },
//                icon: Icon(Icons.search))
//          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTextField(),
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: nodes.length,
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                    itemBuilder: (BuildContext cnt, int index) {
                      // to ensure that a word pairing has not already
                      // been added to favorites.
                      final Node node = nodes[index];

                      final alreadySaved = _saved.contains(node);

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        leading: ExcludeSemantics(
                          child: CircleAvatar(
                            child: Text('${index + 1}',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
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
                            fontSize: 13,
                          ),
                        ),

                        // add heart icons to each row.
                        // Then, make them tappable and save the favorites.
                        trailing: Icon(
                          alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved ? Colors.red : null,
                        ),
                        onTap: () { // NEW lines from here...
                          setState(() {
                            if (alreadySaved) {
                              _saved.remove(node);
                              DBProvider.db.deleteNode(node.id);
                            } else {
                              _saved.add(node);
                              DBProvider.db.insertNode(node);
                            }
                          });

                          print("_saved: $_saved");
                        },
                      );
                    },
                  )
              )

            ],
          ),
        )
    );
  }

  _buildTextField() {
    return CupertinoTextField(
        prefix: const Icon(
          CupertinoIcons.search,
          size: 28,
          color: Colors.black54,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//        clearButtonMode: OverlayVisibilityMode.editing,
//        keyboardType: TextInputType.text,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0,
                  color: CupertinoColors.inactiveGray
              )
          ),
        ),
        placeholder: "Search nodes",
        onChanged: updateNodes
    );
  }
}
