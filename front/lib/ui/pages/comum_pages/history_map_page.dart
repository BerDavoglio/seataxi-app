// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../ui.dart';

class HistoryMapPage extends StatefulWidget {
  final List? origin;
  final List? destination;
  const HistoryMapPage({super.key, this.origin, this.destination});

  @override
  State<HistoryMapPage> createState() => _HistoryMapPageState();
}

class _HistoryMapPageState extends State<HistoryMapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  late List _origin;
  late List _destination;

  @override
  void initState() {
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
      body: Stack(
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
              target: LatLng(_origin[0], _origin[1]),
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
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
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
