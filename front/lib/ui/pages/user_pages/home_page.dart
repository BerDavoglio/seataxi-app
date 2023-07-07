// ignore_for_file: prefer_const_constructors

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../infra/infra.dart';
import '../../ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late GoogleMapController _googleMapController;

  final TextEditingController _numberPeopleController = TextEditingController();

  Position? _position;
  late AdminMaritmeModel _origin;
  late AdminMaritmeModel _destination;

  late String dropdownOrigin;
  late String dropdownDestination;
  late String dropdownType;
  String _dropdownPayment = listPaymentMethod[0];

  bool _sectionOne = false;
  bool _originSelected = false;
  bool _destinationSelected = false;
  bool _sectionTwo = false;
  bool _sectionFinal = false;
  bool _privateTrip = false;

  Future _verifyPermissions() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are denied!");
      }
    }
  }

  Future<Position> _determinePosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() => _position = position);
  }

  void saveOrigin(AdminMaritmeModel data) {
    setState(() {
      _origin = data;
    });
  }

  void saveDestination(AdminMaritmeModel data) {
    setState(() {
      _destination = data;
    });
  }

  static const List<String> listPaymentMethod = <String>[
    'Dinheiro',
    'Credito',
    'Débito',
  ];

  @override
  void initState() {
    _verifyPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyPermissions();
      _getCurrentLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaritmebaseProvider maritmebaseProvider = Provider.of(context);
    BoattypeProvider boattypeProvider = Provider.of(context);
    TripProvider tripProvider = Provider.of(context);

    dropdownOrigin = maritmebaseProvider.maritmebasePublicList[0].title;
    dropdownDestination = maritmebaseProvider.maritmebasePublicList[1].title;
    dropdownType = boattypeProvider.boattypeList[0].title;

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
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Stack(
              children: [
                GoogleMap(
                  onTap: (position) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController controller) async {
                    _customInfoWindowController.googleMapController =
                        controller;
                    _googleMapController = controller;
                  },
                  polylines: !_originSelected && !_destinationSelected
                      ? const <Polyline>{}
                      : <Polyline>{
                          Polyline(
                            polylineId: const PolylineId('trajeto'),
                            color: Colors.blue,
                            width: 5,
                            points: [_origin, _destination]
                                .map((e) => LatLng(e.lat, e.long))
                                .toList(),
                          )
                        },
                  markers: !_originSelected && !_destinationSelected
                      ? addMarkers(
                          _position,
                          maritmebaseProvider.maritmebasePublicList,
                          _customInfoWindowController,
                          (coord) => setState(() {
                            dropdownOrigin = coord.title;
                            _originSelected = true;
                            _customInfoWindowController.hideInfoWindow!();
                            saveOrigin(coord);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Origem `${coord.title}` escolhida com sucesso!'),
                                action: SnackBarAction(
                                  label: 'Fechar',
                                  onPressed: () {},
                                ),
                              ),
                            );
                          }),
                          (coord) => setState(() {
                            dropdownDestination = coord.title;
                            _destinationSelected = true;
                            _customInfoWindowController.hideInfoWindow!();
                            saveDestination(coord);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Destino `${coord.title}` escolhida com sucesso!'),
                                action: SnackBarAction(
                                  label: 'Fechar',
                                  onPressed: () {},
                                ),
                              ),
                            );
                          }),
                        )
                      : addMarkersWithPolyline([_origin, _destination]),
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_position!.latitude, _position!.longitude),
                    zoom: 15,
                  ),
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 200,
                  width: 300,
                  offset: 50,
                ),
                (tripProvider.trip != null && tripProvider.trip?.value != -1)
                    ? sectionConfirmValue(
                        tripProvider.trip,
                        () => setState(
                          () async {
                            await tripProvider.updateAccept(context);

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IdleHomePage(),
                              ),
                            );
                          },
                        ),
                        () => setState(() async {
                          await tripProvider.denyUser(context);

                          _originSelected = false;
                          _destinationSelected = false;
                          _sectionOne = false;
                          _sectionTwo = false;
                          _sectionFinal = false;
                        }),
                      )
                    : !_sectionOne
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: PointerInterceptor(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _sectionOne = true;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.amber,
                                    width: 350,
                                    height: 70,
                                    child: Center(
                                      child: Text(
                                        'Nova Navegação!',
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
                        : !_sectionTwo
                            ? sectionOne(
                                maritmebaseProvider,
                                dropdownOrigin,
                                dropdownDestination,
                                _dropdownPayment,
                                (value) => setState(() {
                                  dropdownOrigin = value!;
                                  _originSelected = true;
                                  int index = maritmebaseProvider
                                      .maritmebasePublicList
                                      .indexWhere(
                                          (item) => item.title == value);
                                  saveOrigin(maritmebaseProvider
                                      .maritmebasePublicList[index]);
                                }),
                                (value) => setState(() {
                                  dropdownDestination = value!;
                                  _destinationSelected = true;
                                  int index = maritmebaseProvider
                                      .maritmebasePublicList
                                      .indexWhere(
                                          (item) => item.title == value);
                                  saveDestination(maritmebaseProvider
                                      .maritmebasePublicList[index]);
                                }),
                                (value) => setState(() {
                                  _dropdownPayment = value!;
                                }),
                                listPaymentMethod,
                              )
                            : !_sectionFinal
                                ? sectionTwo(
                                    _numberPeopleController,
                                    dropdownType,
                                    _privateTrip,
                                    boattypeProvider,
                                    (value) => setState(() {
                                      _privateTrip = value!;
                                    }),
                                    (value) => setState(() {
                                      dropdownType = value!;
                                    }),
                                  )
                                : tripConfirmation(
                                    _origin,
                                    _destination,
                                    _dropdownPayment,
                                    _numberPeopleController,
                                    dropdownType,
                                    _privateTrip,
                                    () {
                                      setState(() async {
                                        int index = boattypeProvider
                                            .boattypeList
                                            .indexWhere((item) =>
                                                item.title == dropdownType);
                                        await tripProvider.createTrip(
                                            context,
                                            CreateTripModel(
                                              origin_id: _origin.id,
                                              destination_id: _destination.id,
                                              boattype_id: index,
                                              people: int.parse(
                                                  _numberPeopleController.text),
                                              method_payment: _dropdownPayment,
                                              private: _privateTrip,
                                            ));
                                        // ignore: prefer_typing_uninitialized_variables
                                        var verify;
                                        while (verify == null) {
                                          // ignore: use_build_context_synchronously
                                          verify = await tripProvider
                                              .getValue(context);
                                        }
                                      });
                                    },
                                  ),
              ],
            ),
      floatingActionButton: _sectionFinal
          ? SizedBox()
          : !_sectionOne
              ? SizedBox(
                  width: 75,
                  height: 75,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () => _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                                _position!.latitude, _position!.longitude),
                            zoom: 15,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.center_focus_strong,
                      ),
                    ),
                  ),
                )
              : !_sectionTwo
                  ? SizedBox(
                      width: 75,
                      height: 75,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          onPressed: () => {
                            if (_originSelected && _destinationSelected)
                              {
                                setState(() {
                                  _sectionTwo = true;
                                })
                              }
                            else
                              {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Favor, escolher um ponto de Origem e um de Destino.'),
                                      action: SnackBarAction(
                                        label: 'Fechar',
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                })
                              }
                          },
                          child: const Icon(
                            Icons.navigate_next,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 75,
                      height: 75,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          onPressed: () => {
                            if (_numberPeopleController.text != '')
                              {
                                setState(() {
                                  _sectionFinal = true;
                                })
                              }
                            else
                              {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Favor, escolher o número de pessoas que irão na viagem.'),
                                      action: SnackBarAction(
                                        label: 'Fechar',
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                })
                              }
                          },
                          child: const Icon(
                            Icons.navigate_next,
                          ),
                        ),
                      ),
                    ),
    );
  }
}
