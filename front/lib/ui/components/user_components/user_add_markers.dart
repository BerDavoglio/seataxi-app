import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/data.dart';

Set<Marker> addMarkers(
  Position? position,
  List<AdminMaritmeModel> list,
  CustomInfoWindowController customInfoWindowController,
  Function selectOrigin,
  Function selectDestination,
) {
  Set<Marker> marks = {};

  marks.add(
    Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      markerId: const MarkerId('you'),
      position: LatLng(position!.latitude, position.longitude),
      infoWindow: const InfoWindow(title: 'You are here!'),
    ),
  );

  for (AdminMaritmeModel coord in list) {
    marks.add(
      Marker(
        markerId: MarkerId(coord.title),
        position: LatLng(coord.lat, coord.long),
        onTap: () {
          customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                              child: SizedBox(
                            height: 70,
                            child: SingleChildScrollView(
                              child: Text(
                                coord.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Latitude: ${coord.lat}',
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Longitude: ${coord.long}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(100, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.green,
                                      ),
                                    ),
                                    onPressed: selectOrigin(coord),
                                    child: const Text(
                                      'Origem',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(100, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.yellow,
                                      ),
                                    ),
                                    onPressed: selectDestination(coord),
                                    child: const Text(
                                      'Destino',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            LatLng(coord.lat, coord.long),
          );
        },
      ),
    );
  }

  return marks;
}

Set<Marker> addMarkersWithPolyline(list) {
    Set<Marker> marks = {};

    for (AdminMaritmeModel coord in list) {
      marks.add(
        Marker(
          markerId: MarkerId(coord.title),
          position: LatLng(coord.lat, coord.long),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    return marks;
  }
