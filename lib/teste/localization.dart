/*
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localization extends StatefulWidget {
  @override
  _LocalizationState createState() => _LocalizationState();
}

class _LocalizationState extends State<Localization> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(0, 0);
  static var location = new Location();

  Future teste() async {

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    return _locationData = await location.getLocation();
  }

  var minhaLocalizacao;

  void pegarLocalizacao() async {
    setState(() async {

      minhaLocalizacao = await teste();
      print(minhaLocalizacao.latitude);
      print(minhaLocalizacao.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    pegarLocalizacao();
  }

  final Set<Marker> _makers2 = {};

  LatLng _lastMapPosition = _center;

  static var latitudes = [-23.5629, -19.9324, -22.0154];
  static var longitudes = [-46.6544, -43.9388, -47.8911];
  static var i = 0;

  LatLng posicaoVetor = LatLng(latitudes[i], longitudes[i]);

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _makers2.add(Marker(
        markerId: MarkerId(LatLng(latitudes[i], longitudes[i]).toString()),
        position: LatLng(latitudes[i], longitudes[i]),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    i++;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.4219983, -122.084),
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _makers2,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
