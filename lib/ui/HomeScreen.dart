import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:outdoor_flutter_app/ui/ActivitySelectionPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      home: HomeScreenState(),
    );
  }
}

class HomeScreenState extends StatefulWidget {
  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  String _mapStyle;
  double _fabHeight;
  double _panelHeightOpen;

  final double _initFabHeight = 120.0;
  final double _panelHeightClosed = 95.0;

  final _center = const LatLng(-26.016063799999998, 28.2250609);

  List widgets = [];
  Completer<GoogleMapController> mapController = Completer();
  BuildContext buildContext;
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<void> checkLocationPermission() async {
    print('Check if service is enabled');
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    print('Has permissions');
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    print('Try to get location');
    _locationData = await location.getLocation();
  }

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    checkLocationPermission();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      drawer: _drawer(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            /*
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,*/
            body: _googleMap(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),

          // the fab

          //the SlidingUpPanel Title
          Positioned(
            top: 30.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                'Tembisa',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: sc,
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  Step getStep(int i) {
    return Step(
      title: Text('Store closed'),
      subtitle: Text('at Tembisa'),
      content: Text("Row ${widgets[i]["title"]}"),
    );
  }

  Future<void> loadData() async {
    var dataURL = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }

  //This Activity's FAB
  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: ActivitySelectionPage('')));
      },
      child: Icon(
        Icons.add,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
  }

  //Drawer
  Drawer _drawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.cloud_done,
              color: Colors.grey,
            ),
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  //Instantiate GoogleMapController
  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    await controller.setMapStyle(_mapStyle);
    await _zoomToPlace();
  }

  Future<void> _zoomToPlace() async {
    var controller = await mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-26.016063799999998, 28.2250609),
          zoom: 16,
        ),
      ),
    );
  }

  //Instantiate Google Maps.
  GoogleMap _googleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
      tiltGesturesEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
    );
  }

  Widget _steps(ScrollController sc) => Container(
        margin: EdgeInsets.only(top: 10),
        child: Stepper(
          steps: [
            Step(
              title: Text('Store closed'),
              subtitle: Text('at Tembisa'),
              content: Text(
                  'In this article, I will tell you how to create a page.'),
            ),
            Step(
                title: Text('Construction'),
                subtitle: Text('at Kempton park'),
                content: Text("Let's look at its construtor."),
                state: StepState.complete,
                isActive: true),
            Step(
                title: Text('Alert'),
                subtitle: Text('at Midrand'),
                content: Text("Let's look at its construtor."),
                state: StepState.error),
          ],
        ),
      );

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 8,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Feed',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            _steps(sc)
          ],
        ));
  }

  Widget listTile() {
    return ListTile(
      leading: Icon(
        Icons.cloud_done,
        color: Colors.grey,
      ),
      title: Text('Item 1'),
      onTap: () {
        // Update the state of the app.
        // ...
      },
    );
  }
}

/*
 * We built a seperate widget to get the Scaffold context so out button can close
 * and open the naavigational drawer
**/
class SeparatedRawMaterialButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: RawMaterialButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          elevation: 5,
          fillColor: Colors.white,
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: SeparatedRawMaterialButtonWidget());
}
