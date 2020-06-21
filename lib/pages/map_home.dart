import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guanasfires/pages/modal/editFire.dart';
import 'package:guanasfires/pages/widget/listFires.dart';
import 'package:guanasfires/services/fireService.dart';
import 'package:guanasfires/theme/util.dart';
import 'package:location/location.dart';

const double CAMERA_ZOOM_HOME = 10;
const double CAMERA_TILT_HOME = 80;
const double CAMERA_BEARING_HOME = 45;
LatLng SOURCE_LOCATION_HOME = LatLng(42.747932, -71.167889);

class MapHome extends StatefulWidget {
  FireService _fireService;
  MapHome(FireService fireService) {
    _fireService = fireService;
  }
  @override
  State<StatefulWidget> createState() => MapHomeState(_fireService);
}

class MapHomeState extends State<MapHome> {
  double latitudP = 0;
  double longitudP = 0;
  FireService _fireService;

  MapHomeState(FireService fireService) {
    _fireService = fireService;
  }

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'AIzaSyCjvTQQxJhFK4PrlCXtfCkRlOl-EIWaZuM';

  BitmapDescriptor fireTrueIcon;
  BitmapDescriptor fireFalseIcon;

  LocationData currentLocation;

  Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/firem.png')
        .then((onValue) {
      fireTrueIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/fired.png')
        .then((onValue) {
      fireFalseIcon = onValue;
    });

    location = new Location();
    polylinePoints = PolylinePoints();

    location.onLocationChanged().listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    setInitialLocation();
  }

  void setInitialLocation() async {
    reloadMap();
    currentLocation = await location.getLocation();
  }

  reloadMap() async {
    new Timer(const Duration(milliseconds: 5000), () {
      for (int i = 0; i < fireList.length; i++) {
        print(fireList.elementAt(i).email);

        loadMark(LatLng(fireList.elementAt(i).lat, fireList.elementAt(i).long),
            fireList.elementAt(i).state, fireList.elementAt(i).key, (i + 0.1));
      }
      new Timer(const Duration(milliseconds: 10000), () async {
        _fireService.reloadData();
      });
      reloadMap();
    });
  }

  loadMark(LatLng positionMark, bool state, String key, double position) {
    var pinPosition = positionMark;

    EditeFireModal modal = new EditeFireModal();

    _markers.removeWhere((m) => m.markerId.value == key);

    _markers.add(Marker(
        markerId: MarkerId(key),
        position: pinPosition,
        onTap: () {
          setState(() {
            pinPillPosition = position + 1;
          });
          modal.mainBottomSheet(context);
        },
        icon: returnIconFire(state)));
    setPolylines();
  }

  loadMarkdRemove(String key) {
    _markers.removeWhere((m) => m.markerId.value == key);

    setPolylines();
  }

  returnIconFire(bool state) {
    if (state) {
      return fireTrueIcon;
    } else {
      return fireFalseIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM_HOME,
        tilt: CAMERA_TILT_HOME,
        bearing: CAMERA_BEARING_HOME,
        target: SOURCE_LOCATION_HOME);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM_HOME,
          tilt: CAMERA_TILT_HOME,
          bearing: CAMERA_BEARING_HOME);
    }
    return Scaffold(
      appBar: AppBar(title: Text("Incendios"), centerTitle: true),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              },
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(UtilsMap.mapStyles);
                _controller.complete(controller);
                showPinsOnMap();
              }),
        ],
      ),
      drawer: listFires(this, _fireService),
    );
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Ubicación Actual",
        location: SOURCE_LOCATION_HOME,
        pinPath: "13",
        avatarPath: "",
        labelColor: Colors.blueAccent);

    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
      onTap: () {
        setState(() {
          pinPillPosition = 0;
        });
      },
    ));
    setPolylines();
  }

  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        currentLocation.latitude,
        currentLocation.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    if (longitudP == 0) {
      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM_HOME,
        tilt: CAMERA_TILT_HOME,
        bearing: CAMERA_BEARING_HOME,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      setState(() {
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        sourcePinInfo.location = pinPosition;

        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      });
    } else {
      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM_HOME,
        tilt: CAMERA_TILT_HOME,
        bearing: CAMERA_BEARING_HOME,
        target: LatLng(latitudP, longitudP),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      setState(() {
        var pinPosition = LatLng(latitudP, longitudP);

        sourcePinInfo.location = pinPosition;

        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      });
    }
  }

  void recolocarCamara(double lat, double long) async {
    latitudP = lat;
    longitudP = long;
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM_HOME,
      tilt: CAMERA_TILT_HOME,
      bearing: CAMERA_BEARING_HOME,
      target: LatLng(lat, long),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      var pinPosition = LatLng(lat, long);

      sourcePinInfo.location = pinPosition;
    });
  }
}

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  Color labelColor;

  PinInformation(
      {this.pinPath,
      this.avatarPath,
      this.location,
      this.locationName,
      this.labelColor});
}

class MapPinPillComponent extends StatefulWidget {
  double pinPillPosition;
  PinInformation currentlySelectedPin;

  MapPinPillComponent({this.pinPillPosition, this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(20),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(left: 10),
                child: ClipOval(
                    child: Image.asset(widget.currentlySelectedPin.avatarPath,
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.currentlySelectedPin.locationName,
                          style: TextStyle(
                              color: widget.currentlySelectedPin.labelColor)),
                      Text(
                          'Latitude: ${widget.currentlySelectedPin.location.latitude.toString()}',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                          'Longitude: ${widget.currentlySelectedPin.location.longitude.toString()}',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(widget.currentlySelectedPin.pinPath,
                    width: 50, height: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
