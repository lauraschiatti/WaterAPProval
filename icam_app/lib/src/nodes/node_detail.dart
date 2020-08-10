import 'package:flutter/material.dart';
import 'package:icam_app/models/node.dart';

class NodeDetailPage extends StatefulWidget {
  @override
  _NodeDetailPageState createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends State<NodeDetailPage> {
  var node;

  @override
  Widget build(BuildContext context) {

    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final Node args = ModalRoute.of(context).settings.arguments;

//    Node.fromJson(
    print(args);

//    findMovie(args.movieId).then((m) {
//      setState(() {
//        movie = m;
//      });
//    });
//
//    if (movie == null) {
//      return new MaterialApp(
//          home: Scaffold(appBar: AppBar(title: Text("")), body: Text("")));
//    }
//
//    return new MaterialApp(
//        home: Scaffold(
//            appBar: AppBar(
//                automaticallyImplyLeading: true,
//                title: Text(movie["Title"]),
//                leading: IconButton(
//                  icon: Icon(Icons.arrow_back),
//                  onPressed: () => Navigator.pop(context, false),
//                )),
//            body: Center(
//                child: Column(children: [
//                    SizedBox(height: 10),
//                    Text(node.toString())
////                    Image.network(movie['Poster'],
////                        fit: BoxFit.cover, height: 400.0, width: 400.0),
////                    SizedBox(height: 10),
////                    Text(movie["Director"]),
////                    SizedBox(height: 10),
////                    Text(movie["Year"]),
////                    SizedBox(height: 10),
////                    Text(movie["Actors"])
////                ]
//                )
//            )
//        )
//    );
  }
}