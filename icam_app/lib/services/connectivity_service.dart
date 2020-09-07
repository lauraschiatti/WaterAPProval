import 'package:data_connection_checker/data_connection_checker.dart';

import 'dart:async';

class ConnectivityService {

  StreamSubscription<DataConnectionStatus> _listener;

  ConnectivityService(){

    // listener
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
  }

}





//import 'dart:async';
//import 'package:data_connection_checker/data_connection_checker.dart';

StreamSubscription<DataConnectionStatus> _listener;

checkInternetConnection() async {
  // Simple check to see if we have internet
  print("The statement 'this machine is connected to the Internet' is: ");
  print(await DataConnectionChecker().hasConnection);

  // We can also get an enum instead of a bool
  print("Current status: ${await DataConnectionChecker().connectionStatus}");
  // prints either DataConnectionStatus.connected
  // or DataConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
//  print("Last results: ${DataConnectionChecker().lastTryResults}");

  //
  var listener = DataConnectionChecker().onStatusChange.listen((status) {
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
//  await Future.delayed(Duration(seconds: 30));
  await listener.cancel();

}