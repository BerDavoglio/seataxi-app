import 'package:flutter/material.dart';

import '../../../data/data.dart';

FractionallySizedBox sectionConfirmValue(
  TripModel? trip,
  Function acceptTripFunction,
  Function negateTripFunction,
) {
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
              const Text(
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
                      'Seu navegador será: ${trip?.navigator_id}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'O preço de sua viagem será de: R\$${trip?.value}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                    onPressed: acceptTripFunction(),
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
                    onLongPress: negateTripFunction(),
                    child: const Text(
                      'Negar',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10),
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
  );
}
