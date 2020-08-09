import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icam_app/models/node.dart';
import 'package:icam_app/theme.dart';

class MapControllerPage extends StatefulWidget {
  MapControllerPage({Key key}) : super(key: key);

  @override
  MapControllerPageState createState() => MapControllerPageState();
}

class MapControllerPageState extends State<MapControllerPage> {

  // google map setup
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(10.421756, -75.549671); // center at cartagena
  LatLng _lastMapPosition = _center; // default center
  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  _onMapCreated(GoogleMapController controller) async{

//    _controller.complete(controller);

    final nodes = await node.FromJson(str);
    final nodes = await  Locations.fromJson(json.decode(response.body));

    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
  }

  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed(){
    setState(() {
      _currentMapType = _currentMapType  == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed(){
    // HEX/RGB to HSV color conversion:
    // 0xFF0288D1 ==> rgb(2, 119, 189) ==> hsl(320, 100%, 51%)
//    const double hue = 202;

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "This is a title",
          snippet: "This is a snippet"
        ),
        icon: BitmapDescriptor.defaultMarker//.defaultMarkerWithHue(hue)
      ));
    });
  }


  Widget button(Function function, IconData icon, String heroTag){
    return new FloatingActionButton(
      heroTag: heroTag,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: myTheme.primaryColor,
      child: Icon(
        icon,
        size: 36.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: Text(appTitle),
//      ),
      body: _buildBody(context)
    );
  }

  _buildBody(context){
    return Stack(
      children: <Widget>[
        GoogleMap(
          //enable zoom gestures
//          zoomGesturesEnabled: true,
          padding: EdgeInsets.only(bottom: 500, top: 0, right: 0, left: 0),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0
          ),
          mapType: _currentMapType,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(_onMapTypeButtonPressed, Icons.map, "btn1"),
                SizedBox(height: 16.0),
                button(_onAddMarkerButtonPressed, Icons.add_location, "btn2"),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Text(
            getTranslated(context, "map_text"),
            style: TextStyle(fontSize: 14)
          )
        )
      ],
    );
  }
}