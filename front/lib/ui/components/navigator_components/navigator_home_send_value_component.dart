import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

FractionallySizedBox navigatorHomeSendValue(
  BuildContext context,
  int? acceptTravelID,
  TextEditingController valueController,
) {
  TripProvider tripProvider = Provider.of(context);

  return FractionallySizedBox(
    widthFactor: 1,
    heightFactor: 1,
    child: Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
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
                'ID: ${acceptTravelID.toString()}',
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
                        tripProvider.tripList[acceptTravelID!].origin_id
                            .toString(),
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
                        tripProvider.tripList[acceptTravelID].destination_id
                            .toString(),
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
                      controller: valueController,
                      decoration: const InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.attach_money_outlined),
                        ),
                        hintText: 'Qual o valor da viagem?',
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
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(100, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                ),
                onPressed: () async {
                  await tripProvider
                      .updateValue(
                    context,
                    acceptTravelID,
                    double.parse(valueController.text),
                  )
                      .then(
                    (value) async {
                      await tripProvider
                          .indexTrip(
                            context,
                            acceptTravelID,
                          )
                          .then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const IdleHomePage(),
                              ),
                            ),
                          );
                    },
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
  );
}
