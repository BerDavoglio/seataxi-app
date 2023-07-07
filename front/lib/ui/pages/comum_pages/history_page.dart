import 'package:flutter/material.dart';
import 'package:front/infra/infra.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of(context);

    List<TripModel> list = tripProvider.tripList;

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
        itemCount: list.length,
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
                                      list[index].origin_id as String,
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
                                      list[index].destination_id as String,
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
                                          .format(list[index].created_at),
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
                                      'R\$${list[index].value.toStringAsFixed(2)}',
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
                                  originId: list[index].origin_id,
                                  destinationId: list[index].destination_id,
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
