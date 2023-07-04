import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../ui.dart';

class NavigatorHomePage extends StatefulWidget {
  const NavigatorHomePage({super.key});

  @override
  State<NavigatorHomePage> createState() => _NavigatorHomePageState();
}

class _NavigatorHomePageState extends State<NavigatorHomePage> {
  NavigatorListModel? _acceptTravel;
  final TextEditingController _valueController = TextEditingController();

  List<NavigatorListModel> data = [
    const NavigatorListModel(
      id: 2,
      name_origin: 'Ilha da Conceição',
      name_destination: 'Companhia de Desenvolvimento da Pesca',
      origin: [-22.87532010837934, -43.11636197595772],
      destination: [-22.87664469785081, -43.1195698978448],
      people_quantity: 30,
      user_stars: 4.6,
    ),
    const NavigatorListModel(
      id: 4,
      name_origin: 'Ilha da Conceição',
      name_destination: 'NENAVAL ENGENHARIA NAVAL E OFFSHORE LTDA',
      origin: [-22.87532010837934, -43.11636197595772],
      destination: [-22.87990669158874, -43.12118995199219],
      people_quantity: 25,
      user_stars: 4.2,
    ),
    const NavigatorListModel(
      id: 8,
      name_origin: 'Ilha da Conceição',
      name_destination: 'Estaleiro Mauá S/A',
      origin: [-22.87532010837934, -43.11636197595772],
      destination: [-22.877257563310657, -43.12885034120929],
      people_quantity: 10,
      user_stars: 4.8,
    ),
    const NavigatorListModel(
      id: 12,
      name_origin: 'Ilha da Conceição',
      name_destination: 'Companhia de Desenvolvimento da Pesca',
      origin: [-22.87532010837934, -43.11636197595772],
      destination: [-22.87664469785081, -43.1195698978448],
      people_quantity: 56,
      user_stars: 3.6,
    ),
    const NavigatorListModel(
      id: 22,
      name_origin: 'Ilha da Conceição',
      name_destination: 'NEstação General Dutra - EFL',
      origin: [-22.87532010837934, -43.11636197595772],
      destination: [-22.882535999145635, -43.11608302627564],
      people_quantity: 7,
      user_stars: 4.9,
    ),
  ];

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
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
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
                                          child:
                                              Text(data[index].id.toString())),
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
                                          child: Text(data[index].name_origin)),
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
                                              data[index].name_destination)),
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
                                              '${data[index].people_quantity}')),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Estrelas do Usuário: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                              '${data[index].user_stars}')),
                                    ],
                                  ),
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
                                      _acceptTravel = data[index];
                                      ;
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
                                  data.removeWhere(
                                      (item) => item.id == data[index].id);
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
          if (_acceptTravel != null)
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
                          'ID: ${_acceptTravel!.id.toString()}',
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
                                  _acceptTravel!.name_origin,
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
                                  _acceptTravel!.name_destination,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IdleHomePage(
                                  origin: _acceptTravel!.origin,
                                  destination: _acceptTravel!.destination,
                                ),
                              ),
                            );
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
