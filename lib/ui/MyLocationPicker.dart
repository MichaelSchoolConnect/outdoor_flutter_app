import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationPicker extends StatefulWidget {
  @override
  _MyLocationPickerState createState() => _MyLocationPickerState();
}

class _MyLocationPickerState extends State<MyLocationPicker> {
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  var result = await showLocationPicker(
                    context,
                    'AIzaSyDMVFYHvldlg3K78tQ5PG7UlFLBOubuCnQ',
                    initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                    myLocationButtonEnabled: true,
                    layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                  );
                  // ignore: prefer_single_quotes
                  print("result = $result");
                  setState(() => _pickedLocation = result);
                },
                child: Text('Pick location'),
              ),
              Text(_pickedLocation.toString()),
            ],
          ),
        );
      }),
    );
  }
}
