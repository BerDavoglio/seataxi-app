import 'package:flutter/material.dart';

import '../../../data/data.dart';

FractionallySizedBox tripConfirmation(
  AdminMaritmeModel origin,
  AdminMaritmeModel destination,
  String dropdownPayment,
  TextEditingController numberPeopleController,
  String boattype,
  bool privateTrip,
  Function func,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Origem: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          origin.title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Destino: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          destination.title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Método de Pagamento: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dropdownPayment,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Número de Passageiros: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          numberPeopleController.text,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Tipo de Embarcação: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          boattype,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Viagem provada? ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          privateTrip ? "Sim" : "Não",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(22, 58, 89, 1)),
                ),
                onPressed: func(),
                child: const Text('Chamar Navegador',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
