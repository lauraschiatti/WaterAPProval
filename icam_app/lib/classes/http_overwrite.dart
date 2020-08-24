
import 'dart:io';


// facilitates overriding HttpClient with a mock implementation
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    // create a `SecurityContext` instance to trust you certificate
    return super.createHttpClient(context)
    // add support for badCertificateCallback.
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
