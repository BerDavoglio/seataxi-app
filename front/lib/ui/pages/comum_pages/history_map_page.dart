// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front/infra/providers/crud/maritmebase_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../ui.dart';

class HistoryMapPage extends StatefulWidget {
  final int? originId;
  final int? destinationId;
  const HistoryMapPage({super.key, this.originId, this.destinationId});

  @override
  State<HistoryMapPage> createState() => _HistoryMapPageState();
}

class _HistoryMapPageState extends State<HistoryMapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  late int _originId;
  late int _destinationId;

  @override
  void initState() {
    _originId = widget.originId!;
    _destinationId = widget.destinationId!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaritmebaseProvider maritmebaseProvider = Provider.of(context);

    List<AdminMaritmeModel> list = maritmebaseProvider.maritmebasePublicList;

    int indexOrigin = list.indexWhere((item) => item.id == _originId);
    int indexDestination = list.indexWhere((item) => item.id == _destinationId);

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
              target: LatLng(
                list[indexOrigin].lat,
                list[indexOrigin].long,
              ),
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
