import UIKit
import Flutter
import Foundation
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // provide Google Maps API key
    let googleMapApiKey = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"]
    
    // TODO: set credentials from environment
    //GMSServices.provideAPIKey(environment["MAPS_API_KEY"])
//    if ([mapsApiKey length] == 0) {
//      mapsApiKey = @"YOUR KEY HERE";
//    }
    GMSServices.provideAPIKey("AIzaSyDR6hvAUDS9Jgd9i4c0jfTemCVGLoIgL6g")//googleMapApiKey)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
