import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/routes/route_names.dart';
import 'package:icam_app/services/nodes_db_provider.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/classes/widgets.dart';


class NodesShowPage extends StatefulWidget {

  @override
  _NodesShowPageState createState() => _NodesShowPageState();

}

class _NodesShowPageState extends State<NodesShowPage> {

  List<Node> _initialList;
  Future _initialListFuture;
  List<Node> _currentList = [];

  // get all nodes
  _getNodes() async {
    final _nodeData = await getNodeFromFakeServer();
    return _nodeData;
  }

  // the nodes can be filtered with this filters.
  String name = "";
  String status = "All";

  List<String> statusList = ["All", "Real Time", "Non Real Time", "Off"];

  final _controller = new TextEditingController();
  final _saved = Set<Node>();

  @override
  initState() {
    super.initState();
    _initialListFuture = _getNodes();
    print("filterNodes() _initialListFuture $_initialListFuture");
    _controller.addListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text(getTranslated(context, "available_nodes")),
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  _showConventionDialog();
                },
              ),
            ]
//          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()async{
//            Navigator.pop(context,"From BackButton");
//          }),
        ),
        body: GestureDetector(
          onTap: () {
            //  hide the soft keyboard clicking anywhere on the screen.
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: FutureBuilder(
              future: _initialListFuture,
              builder: (context, snapshot) {
                //  if (snapshot.hasError) {
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
                  _initialList = snapshot.data;

                  List<Node> tmp = filterNodes();

                  return Container(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: _buildTextField(),
                        ),
                        ListTile(
                            leading: Text(
                                getTranslated(context, "node_status")),
                            trailing: DropdownButton(
                                elevation: 5,
                                onChanged: (item) {
                                  setState(() {
                                    if (item != null) {
                                      status = item;
                                    } else {
                                      status = "all";
                                    }
                                  });
                                },
                                hint: Text(status),
                                items: [
                                  DropdownMenuItem<String>(
                                      value: getTranslated(context, "all"),
                                      child: Text(getTranslated(context, "all"))
                                  ),
                                  DropdownMenuItem<String>(
                                      value: getTranslated(context, "real_time"),
                                      child: Text(getTranslated(context, "real_time"))
                                  ),
                                  DropdownMenuItem<String>(
                                      value: getTranslated(context, "non_real_time"),
                                      child: Text(getTranslated(context, "non_real_time"))
                                  ),
                                  DropdownMenuItem<String>(
                                      value: getTranslated(context, "off"),
                                      child: Text(getTranslated(context, "off"))
                                  )
                                ]

                            )
                        ),
                        _buildListBuilder(tmp)
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
          ),
        )
    );
  }

  _buildTextField() {
    return CupertinoTextField(
      controller: _controller,
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
      placeholder: getTranslated(context, "search_fav_nodes"),
    );
  }

  _buildListBuilder(tmp) {

    if(tmp.isEmpty){
      return Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Text(getTranslated(context, "no_nodes"),
              style: TextStyle(
                  fontWeight: FontWeight.w400
              ),
            ),
          )
      );

    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: _currentList.length,
            itemBuilder: (BuildContext context, int index) {
              Node current = _currentList.elementAt(index);

              // alreadySaved are those on _saved or already saved as fav on the db
              final alreadySaved = _saved.contains(current);

              Color _statusColor = Colors.black12;

              if (statusList.contains(current.status)) {
                _statusColor = myTheme.primaryColor;
              }

              Icon _statusIcon = Icon(
                  Icons.brightness_1,
                  size: 30,
                  color: _statusColor
              );

              return Card(
                elevation: 18.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: _statusIcon,
                  title: Text(
                    current.name,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  subtitle: Text(
                    current.location,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    icon: alreadySaved ? Icon(Icons.favorite) : Icon(
                        Icons.favorite_border),
                    color: alreadySaved ? Colors.red : null,
                    onPressed: () {
                      setState(() {
                        if (alreadySaved) {
                          _saved.remove(current);
                          DBProvider.db.deleteNode(current.id);
                        } else {
                          _saved.add(current);
                          DBProvider.db.insertNode(current);
                        }
                      });

                      print("_saved: $_saved");
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        nodeDetailRoute,
                        arguments: current
                    );
                  },
                ),
              );
            }
        ),
      );
    }
  }

  onChange() {
    setState(() {});
  }

  filterNodes() {
    print("filterNodes() _initialList $_initialList");
    // Prepare lists
    List<Node> tmp = [];
    _currentList.clear();

    String name = _controller.text;
    print("filter cars for name " + name);
    if (name.isEmpty) {
      tmp.addAll(_initialList);
    } else {
      for (Node n in _initialList) {
        if (n.name.toLowerCase().startsWith(name.toLowerCase())) {
          tmp.add(n);
        }
      }
    }
    print("filterNodes() name: currentList $_currentList");
    _currentList = tmp;

    if (status != "All") {
      tmp = [];
      print("filter nodes for status " + status);
      for (Node n in _currentList) {
        if (n.status == status) {
          tmp.add(n);
        }
      }

      print("filterNodes() status: currentList $_currentList");
      _currentList = tmp;
    }

    return tmp;
  }

  // ICAMpff values AlertDialog
  Future<void> _showConventionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 15,15, 0),
          title: Text(
            getTranslated(context, "status_convention"),
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ListBody(
              children: <Widget>[
                DialogItem(
                  icon: Icons.brightness_1,
                  color: myTheme.primaryColor,
                  text: getTranslated(context, "known_status"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.black12,
                  text: getTranslated(context, "unknown_status"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(getTranslated(context, "close")),
              color: myTheme.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}