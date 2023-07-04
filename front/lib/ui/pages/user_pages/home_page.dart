// ignore_for_file: prefer_const_constructors

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
  String dropdownOrigin = listNameCoord[0];
  String dropdownDestination = listNameCoord[1];
  String dropdownPayment = listPaymentMethod[0];
  String dropdownType = listNameType[0];
  String _boatType = listNameType[0];
  double _priceForRide = 0;
  bool _privateTrip = false;
  bool _originDestSelected = false;
  bool _sectionOne = false;
  bool _sectionTwo = false;
  bool _sectionFinal = false;
  List _origin = [];
  List _destination = [];
  Position? _position;
  final TextEditingController _numberPeopleController = TextEditingController();

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
  }

  void saveOrigin(lat, long, name, desc) {
    setState(() {
      _origin = [lat, long, name, desc];
    });
  }

  void saveDestination(lat, long, name, desc) {
    _destination = [lat, long, name, desc];
  }

  static List listLatLong = [
    [
      -22.87532010837934,
      -43.11636197595772,
      'Ilha da Conceição',
      'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
    ],
    [
      -22.87664469785081,
      -43.1195698978448,
      'Companhia de Desenvolvimento da Pesca',
      'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
    ],
    [
      -22.87990669158874,
      -43.12118995199219,
      'NENAVAL ENGENHARIA NAVAL E OFFSHORE LTDA',
      'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
    ],
    [
      -22.882535999145635,
      -43.11608302627564,
      'NEstação General Dutra - EFL',
      'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
    ],
    [
      -22.877257563310657,
      -43.12885034120929,
      'Estaleiro Mauá S/A',
      'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
    ],
  ];

  static const List<String> listNameCoord = <String>[
    'Origem',
    'Destino',
    'Name 1',
    'Name 2',
    'Name 3',
    'Name 4',
    'Name 5',
  ];

  Set<Marker> _addMarkers(list) {
    Set<Marker> marks = {};

    marks.add(
      Marker(
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        markerId: MarkerId('you'),
        position: LatLng(_position!.latitude, _position!.longitude),
        infoWindow: InfoWindow(title: 'You are here!'),
      ),
    );

    for (List coord in list) {
      marks.add(
        Marker(
          markerId: MarkerId(coord[2]),
          position: LatLng(coord[0], coord[1]),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
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
                                  coord[2].toString(),
                                  style: TextStyle(
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
                                      'Latitude: ${coord[0]}',
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Longitude: ${coord[1].toString()}',
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
                                                Size(100, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          dropdownOrigin = coord[2];
                                          _customInfoWindowController
                                              .hideInfoWindow!();
                                          saveOrigin(
                                            coord[0],
                                            coord[1],
                                            coord[2],
                                            coord[3],
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Origem `${coord[2]}` escolhida com sucesso!'),
                                              action: SnackBarAction(
                                                label: 'Fechar',
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text(
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
                                                Size(100, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.yellow,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _customInfoWindowController
                                              .hideInfoWindow!();
                                          dropdownDestination = coord[2];
                                          saveDestination(
                                            coord[0],
                                            coord[1],
                                            coord[2],
                                            coord[3],
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Destino `${coord[2]}` escolhida com sucesso!'),
                                              action: SnackBarAction(
                                                label: 'Fechar',
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text(
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
              LatLng(coord[0], coord[1]),
            );
          },
        ),
      );
    }

    return marks;
  }

  Set<Marker> _addMarkersWithPolyline(list) {
    Set<Marker> marks = {};

    for (List coord in list) {
      marks.add(
        Marker(
          markerId: MarkerId(coord[2]),
          position: LatLng(coord[0], coord[1]),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    return marks;
  }

  List<DropdownMenuItem<String>> createDropdownCoordItems() {
    return listNameCoord.map<DropdownMenuItem<String>>((String value) {
      if (value == 'Origem' || value == 'Destino') {
        return DropdownMenuItem<String>(
          enabled: false,
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
          ),
        );
      }
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    }).toList();
  }

  static const List<String> listPaymentMethod = <String>[
    'Dinheiro',
    'Credito',
    'Débito',
  ];

  List<DropdownMenuItem<String>> createDrowpdownPaymentItems() {
    return listPaymentMethod.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    }).toList();
  }

  static const List<String> listNameType = <String>[
    'Barco 1',
    'Barco 2',
  ];

  List<DropdownMenuItem<String>> createDropdownTypeItems() {
    return listNameType.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    }).toList();
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
    _googleMapController.dispose();
    _customInfoWindowController.dispose();
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
                  polylines: !_originDestSelected
                      ? const <Polyline>{}
                      : <Polyline>{
                          Polyline(
                            polylineId: const PolylineId('trajeto'),
                            color: Colors.blue,
                            width: 5,
                            points: [_origin, _destination]
                                .map((e) => LatLng(e[0], e[1]))
                                .toList(),
                          )
                        },
                  markers: !_originDestSelected
                      ? _addMarkers(listLatLong)
                      : _addMarkersWithPolyline([_origin, _destination]),
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
                _priceForRide != 0
                    ? FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.6)),
                          child: Center(
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Valor definido!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Seu navegador será: NOME DO NAVEGADOR',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          'O preço de sua viagem será de: R\$$_priceForRide',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
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
                                                  Size(100, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.green,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      IdleHomePage(
                                                    origin: _origin,
                                                    destination: _destination,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Aceitar',
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
                                                  Size(100, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.red,
                                          ),
                                        ),
                                        onPressed: () {
                                          // Do nothing with this!
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            // Negar Preço do Navegador.
                                            _sectionOne = false;
                                            _sectionTwo = false;
                                            _sectionFinal = false;
                                            _priceForRide = 0;
                                          });
                                        },
                                        child: Text(
                                          'Negar',
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Para negar o valor da Ride, favor apertar e segurar o botão de negar!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: PointerInterceptor(
                                        child: Container(
                                          color: Colors.amber,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              itemHeight: 70,
                                              value: dropdownOrigin,
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: const Icon(
                                                    Icons.arrow_drop_down),
                                              ),
                                              elevation: 16,
                                              isExpanded: true,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  dropdownOrigin = value!;
                                                  int index = listLatLong
                                                      .indexWhere((item) =>
                                                          item[2] == value);
                                                  saveOrigin(
                                                    listLatLong[index][0],
                                                    listLatLong[index][1],
                                                    listLatLong[index][2],
                                                    listLatLong[index][3],
                                                  );
                                                });
                                              },
                                              items: createDropdownCoordItems(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: PointerInterceptor(
                                        child: Container(
                                          color: Colors.amber,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              itemHeight: 70,
                                              value: dropdownDestination,
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: const Icon(
                                                    Icons.arrow_drop_down),
                                              ),
                                              elevation: 16,
                                              isExpanded: true,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  dropdownDestination = value!;
                                                  int index = listLatLong
                                                      .indexWhere((item) =>
                                                          item[2] == value);
                                                  saveDestination(
                                                    listLatLong[index][0],
                                                    listLatLong[index][1],
                                                    listLatLong[index][2],
                                                    listLatLong[index][3],
                                                  );
                                                });
                                              },
                                              items: createDropdownCoordItems(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: PointerInterceptor(
                                        child: Container(
                                          color: Colors.amber,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              itemHeight: 70,
                                              value: dropdownPayment,
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: const Icon(
                                                    Icons.arrow_drop_down),
                                              ),
                                              elevation: 16,
                                              isExpanded: true,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  dropdownPayment = value!;
                                                });
                                              },
                                              items:
                                                  createDrowpdownPaymentItems(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : !_sectionFinal
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: PointerInterceptor(
                                            child: Container(
                                              height: 70,
                                              color: Colors.amber,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    _numberPeopleController,
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Icon(Icons.person),
                                                  ),
                                                  hintText:
                                                      'Quantas pessoas irão na viagem?',
                                                  labelText:
                                                      'Número de pessoas',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: PointerInterceptor(
                                            child: Container(
                                              color: Colors.amber,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  itemHeight: 70,
                                                  value: dropdownType,
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: const Icon(
                                                        Icons.arrow_drop_down),
                                                  ),
                                                  elevation: 16,
                                                  isExpanded: true,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      dropdownType = value!;
                                                      _boatType = value;
                                                    });
                                                  },
                                                  items:
                                                      createDropdownTypeItems(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: PointerInterceptor(
                                            child: Container(
                                                height: 70,
                                                width: 350,
                                                color: Colors.amber,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.grey,
                                                      value: _privateTrip,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _privateTrip = value!;
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      'Viagem Privada?',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : FractionallySizedBox(
                                    widthFactor: 1,
                                    heightFactor: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.6)),
                                      child: Center(
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Confire sua Viagem!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Origem: ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_origin[2]}',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Destino: ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_destination[2]}',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Método de Pagamento: ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          dropdownPayment,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Número de Passageiros: ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          _numberPeopleController
                                                              .text,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Tipo de Embarcação: ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          _boatType,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Viagem provada? ',
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          _privateTrip
                                                              ? "Sim"
                                                              : "Não",
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromRGBO(
                                                              22, 58, 89, 1)),
                                                ),
                                                child: Text('Chamar Navegador',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                onPressed: () {
                                                  setState(() {
                                                    // Fazer a requisição com os valores.
                                                    _priceForRide = 100;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                            if (_origin.isNotEmpty && _destination.isNotEmpty)
                              {
                                setState(() {
                                  _originDestSelected = true;
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
