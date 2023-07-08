import 'package:flutter/material.dart';

import '../../../infra/infra.dart';

Padding navigatorHomeItem(
  TripProvider tripProvider,
  int index,
  Function acceptFunc,
  Function denyFunc,
) {
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
                              child: Text(
                                  tripProvider.tripList[index].id.toString())),
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
                              tripProvider.tripList[index].origin_id.toString(),
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
                              tripProvider.tripList[index].destination_id
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
                        MaterialStateProperty.all<Color>(Colors.black),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  onPressed: acceptFunc(),
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
                        MaterialStateProperty.all<Color>(Colors.black),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                  ),
                  onPressed: () {},
                  onLongPress: denyFunc(),
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
}
