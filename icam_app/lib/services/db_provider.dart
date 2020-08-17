import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:icam_app/models/node.dart';

final FAVORITE_NODES_TABLE_NAME = "favorite_nodes";

class DBProvider {

  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  // if DB instance does not exist, create one,
  // otherwise return the existing one
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  Future<Database> initDB() async{
    return await openDatabase(
        join(await getDatabasesPath(), "icam_app.db"), // path
        // When the database is first created, create a table to store dogs.
        onCreate: (Database db, int version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            "CREATE TABLE favorite_nodes(_id STRING PRIMARY KEY, "
                "name TEXT, "
                "location TEXT,"
                "status TEXT)",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 2
    );
  }

  // insert nodes into the database
  Future<void> insertNode(Node node) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Node into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same Node is inserted twice.
    // In this case, replace any previous data.
    await db.insert(
      FAVORITE_NODES_TABLE_NAME,
      node.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("node id: ${node.id}, name: ${node.name} saved");
  }

  // retrieve all the nodes from the favorite_nodes table.
  Future<List<Node>> getNodes() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Nodes.
//    var res = await db.query(FAVORITE_NODES_TABLE_NAME);
//
//    if (res.length == 0){
//      return null;
//    } else {
//      var resMap = res[0];
//      return resMap.isNotEmpty ? resMap : null;
//    }
    final List<Map<String, dynamic>> maps =
            await db.query(FAVORITE_NODES_TABLE_NAME);


    // convert the List<Map> into a List<Node>.
    return List.generate(maps.length, (i) {
      return Node(
          id: maps[i]['_id'],
          name: maps[i]['name'],
          location: maps[i]['location'],
          status: maps[i]['status']
      );
    });
  }


  // delete a node
  Future<void> deleteNode(String id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Node from the database.
    await db.delete(
      FAVORITE_NODES_TABLE_NAME,
      // Use a `where` clause to delete a specific node.
      where: "_id = ?",
      // Pass the Node's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );

    print("node with id: $id deleted");
  }

}