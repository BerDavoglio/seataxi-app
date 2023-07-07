import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

Column sectionTwo(
  TextEditingController numberPeopleController,
  String dropdownType,
  bool privateTrip,
  BoattypeProvider boattypeProvider,
  Function changeTypeFunction,
  Function changePrivateFunction,
) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: PointerInterceptor(
            child: Container(
              height: 70,
              color: Colors.amber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: numberPeopleController,
                decoration: const InputDecoration(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(Icons.person),
                  ),
                  hintText: 'Quantas pessoas irão na viagem?',
                  labelText: 'Número de pessoas',
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: PointerInterceptor(
            child: Container(
              color: Colors.amber,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  itemHeight: 70,
                  value: dropdownType,
                  icon: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String? value) {
                    changeTypeFunction(value);
                  },
                  items: createDropdownTypeItems(boattypeProvider.boattypeList),
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      value: privateTrip,
                      onChanged: (bool? value) {
                        changePrivateFunction(value);
                      },
                    ),
                    const Text(
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
  );
}
