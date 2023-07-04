// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../ui.dart';

class NavigatorRoutePage extends StatefulWidget {
  final List? origin;
  final List? destination;
  const NavigatorRoutePage({super.key, this.origin, this.destination});

  @override
  State<NavigatorRoutePage> createState() => _NavigatorRoutePageState();
}

class _NavigatorRoutePageState extends State<NavigatorRoutePage> {
  Position? _position;
  final Completer<GoogleMapController> _controller = Completer();

  late List _origin;
  late List _destination;

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are denied!");
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() => _position = position);

    GoogleMapController googleMapController = await _controller.future;

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    ).listen(
      (Position? position) {
        _position = position;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 15,
              target: LatLng(
                position!.latitude,
                position.longitude,
              ),
            ),
          ),
        );

        if (position.latitude == _destination[0] &&
            position.longitude == _destination[1]) {
          // Terminar corrida!
        }

        setState(() => {});
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
    _origin = widget.origin!;
    _destination = widget.destination!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: homeDrawer(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        toolbarHeight: 70,
        title: const Text(
          'SeaTaxi',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: _position == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Stack(
              children: [
                GoogleMap(
                  polylines: <Polyline>{
                    Polyline(
                      polylineId: const PolylineId('trajeto'),
                      color: Colors.blue,
                      width: 5,
                      points: [
                        [_origin[0], _origin[1]],
                        [_destination[0], _destination[1]]
                      ].map((e) => LatLng(e[0], e[1])).toList(),
                    )
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('Person'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueMagenta),
                      position: LatLng(
                        _position!.latitude,
                        _position!.longitude,
                      ),
                    ),
                    Marker(
                      markerId: MarkerId('Origin'),
                      position: LatLng(
                        _origin[0],
                        _origin[1],
                      ),
                    ),
                    Marker(
                      markerId: MarkerId('Origin'),
                      position: LatLng(
                        _destination[0],
                        _destination[1],
                      ),
                    ),
                  },
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_position!.latitude, _position!.longitude),
                    zoom: 15,
                  ),
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PointerInterceptor(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.NAVHOME);
                        },
                        child: Container(
                          color: Colors.amber,
                          width: 350,
                          height: 70,
                          child: const Center(
                            child: Text(
                              'Finalizar Navegação!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
