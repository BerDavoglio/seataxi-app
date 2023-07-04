import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

class NavigatorHomePage extends StatefulWidget {
  const NavigatorHomePage({super.key});

  @override
  State<NavigatorHomePage> createState() => _NavigatorHomePageState();
}

class _NavigatorHomePageState extends State<NavigatorHomePage> {
  int? _acceptTravelID;
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of(context);

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
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tripProvider.tripList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 150,
                  color: Colors.amber,
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'ID: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(tripProvider
                                              .tripList[index].id
                                              .toString())),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Origem: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tripProvider.tripList[index].origin_id
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Destino: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tripProvider
                                              .tripList[index].destination_id
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Quantidade de Pessoas: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                              '${tripProvider.tripList[index].people}')),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     const Text(
                                  //       'Estrelas do Usuário: ',
                                  //       style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //         child: Text(
                                  //             '${tripProvider.tripList[index].user_stars}')),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    setState(() {
                                      _acceptTravelID = index;
                                    });
                                  },
                                );
                              },
                              child: const Text(
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
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  tripProvider.tripList.removeWhere((item) =>
                                      item.id ==
                                      tripProvider.tripList[index].id);
                                });
                              },
                              child: const Text(
                                'Negar',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_acceptTravelID != null)
            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 1,
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Valor da Viagem?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'ID: ${_acceptTravelID.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Origem: ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  tripProvider.tripList[_acceptTravelID!].origin_id.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Destino: ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  tripProvider.tripList[_acceptTravelID!].destination_id.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: PointerInterceptor(
                            child: Container(
                              height: 70,
                              color: Colors.amber,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _valueController,
                                decoration: const InputDecoration(
                                  icon: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Icon(Icons.attach_money_outlined),
                                  ),
                                  hintText: 'Quantas pessoas irão na viagem?',
                                  labelText: 'Valor da Viagem',
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(100, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green,
                            ),
                          ),
                          onPressed: () {
                            // Salvar no servidor qual o valor da corrida.
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => IdleHomePage(
                            //       origin: tripProvider.tripList[_acceptTravelID!].origin_id,
                            //       destination: tripProvider.tripList[_acceptTravelID!].origin_id,
                            //     ),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'Enviar Valor',
                          ),
                        ),
                      ],
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
