import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';

// check network connectivity
//  var _connectionStatus = 'Unknown';
//  Connectivity _connectivity;// = Connectivity();
// listen for network state changes
//  StreamSubscription<ConnectivityResult> _connectivitySubscription;
//  var isDeviceConnected = false;
StreamSubscription<DataConnectionStatus> _listener;

checkInternet() async {
  // Simple check to see if we have internet
  print("The statement 'this machine is connected to the Internet' is: ");
  print(await DataConnectionChecker().hasConnection);
  // returns a bool

  // We can also get an enum instead of a bool
  print("Current status: ${await DataConnectionChecker().connectionStatus}");
  // prints either DataConnectionStatus.connected
  // or DataConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
  print("Last results: ${DataConnectionChecker().lastTryResults}");

  // actively listen for status updates
  _listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case DataConnectionStatus.connected:
        print('Data connection is available.');
        break;
      case DataConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });

  // close listener after 30 seconds, so the program doesn't run forever
  await Future.delayed(Duration(seconds: 30));
}

// Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initConnectivity() async {
//    ConnectivityResult result;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      result = await _connectivity.checkConnectivity();
//    } on PlatformException catch (e) {
//      print(e.toString());
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) {
//      return Future.value(null);
//    }
//
//    return _updateConnectionStatus(result);
//  }

// network connection snackbar
//_buildSnackBar() {
//  return Container(
//    padding: EdgeInsets.all(8.0),
//    child: MaterialButton(
//      onPressed: () {
//        final snackBar = SnackBar(
//          content: Text("your'e Offline"),
//        );
//        _scaffoldKey.currentState.showSnackBar(snackBar);
//      },
//      color: Colors.blue,
//      child: Text(
//        "Show Simple SnackBar",
//        style: TextStyle(color: Colors.white),
//      ),
//    ),
//  );
//}