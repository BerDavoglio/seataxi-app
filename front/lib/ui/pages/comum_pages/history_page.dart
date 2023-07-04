import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';
import '../../ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<HistoryModel> _listHistory = [
    HistoryModel(
      id: 1,
      date: DateTime.parse('2023-07-20 20:18:04Z'),
      origin: [
        -22.87532010837934,
        -43.11636197595772,
        'Ilha da Conceição',
        'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
      ],
      destination: [
        -22.87664469785081,
        -43.1195698978448,
        'Companhia de Desenvolvimento da Pesca',
        'Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica - Descrição Genérica',
      ],
      value: 129.00,
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
          'Histórico',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _listHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 100,
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
                                    'Origem: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      _listHistory[index].origin[2],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                  Flexible(
                                    child: Text(
                                      _listHistory[index].destination[2],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Data: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      DateFormat('dd/MM/yyyy HH:mm')
                                          .format(_listHistory[index].date),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Valor: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'R\$${_listHistory[index].value.toStringAsFixed(2)}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryMapPage(
                                  origin: _listHistory[index].origin,
                                  destination: _listHistory[index].destination,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Ver no mapa',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
