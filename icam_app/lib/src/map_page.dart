import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:latlong/latlong.dart';

class MapControllerPage extends StatefulWidget {
  MapControllerPage({Key key}) : super(key: key);

  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

class MapControllerPageState extends State<MapControllerPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng quintas = LatLng(10.407163, -75.5279817);
  static LatLng juan_angola = LatLng(10.44262, -75.5216947);
  static LatLng cabrero = LatLng(10.430926, -75.542428);

//  MapController mapController;
//
//  @override
//  void initState() {
//    super.initState();
//    mapController = MapController();
//  }

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
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: cabrero,
        builder: (ctx) => Container(
          key: Key('blue'),
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.blue,
            iconSize: 55.0,
            onPressed: () {
              print('cabrero Marker tappesssd');
            },
          ),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: quintas,
        builder: (ctx) => Container(
          key: Key('blue'),
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.blue,
            iconSize: 55.0,
            onPressed: () {
              print('quintas Marker tappesssd');
            },
          ),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: juan_angola,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.blue,
            iconSize: 55.0,
            onPressed: () {
              print('juan_angola Marker tappesssd');
            },
          ),
        ),
      ),
    ];

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: FlutterMap(
//              mapController: mapController,
              options: MapOptions(
                center: LatLng(10.4241961, -75.535), // cartageba
//                  zoom: 14.0,
                maxZoom: 18.0,
                minZoom: 12.0,

              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  // For example purposes. It is recommended to use
                  // TileProvider with a caching and retry strategy, like
                  // NetworkTileProvider or CachedNetworkTileProvider
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                MarkerLayerOptions(markers: markers)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
                getTranslated(context, "map_text"),
                    style: TextStyle(
                      fontSize: 14
                    )
            ),
          )
        ],
      ),
    );
  }
}