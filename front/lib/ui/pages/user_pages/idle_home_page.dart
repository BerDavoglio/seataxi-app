// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/infra/infra.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';

class IdleHomePage extends StatefulWidget {
  const IdleHomePage({super.key});

  @override
  State<IdleHomePage> createState() => _IdleHomePageState();
}

class _IdleHomePageState extends State<IdleHomePage> {
  Position? _position;
  final Completer<GoogleMapController> _controller = Completer();

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

        setState(() => {});
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaritmebaseProvider maritmebaseProvider = Provider.of(context);
    TripProvider tripProvider = Provider.of(context);

    List<AdminMaritmeModel> list = maritmebaseProvider.maritmebasePublicList;

    int indexOrigin =
        list.indexWhere((item) => item.id == tripProvider.trip?.origin_id);
    int indexDestination =
        list.indexWhere((item) => item.id == tripProvider.trip?.destination_id);

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
                        [
                          list[indexOrigin].lat,
                          list[indexOrigin].long,
                        ],
                        [
                          list[indexDestination].lat,
                          list[indexDestination].long,
                        ]
                      ].map((e) => LatLng(e[0], e[1])).toList(),
                    )
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('Person'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueMagenta),
                      position: LatLng(
                        _position!.latitude,
                        _position!.longitude,
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId('Origin'),
                      position: LatLng(
                        list[indexOrigin].lat,
                        list[indexOrigin].long,
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId('Origin'),
                      position: LatLng(
                        list[indexDestination].lat,
                        list[indexDestination].long,
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
                          tripProvider.finishTrip(context);
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
