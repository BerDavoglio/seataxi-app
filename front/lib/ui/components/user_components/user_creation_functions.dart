import 'package:flutter/material.dart';

import '../../../data/data.dart';

List<DropdownMenuItem<String>> createDropdownCoordItems(
  List<AdminMaritmeModel> list,
) {
  List<String> listNameCoord = [];
  list.map((value) => {
        listNameCoord.add(value.title),
      });

  return listNameCoord.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }).toList();
}

List<DropdownMenuItem<String>> createDrowpdownPaymentItems(list) {
  return list.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }).toList();
}

List<DropdownMenuItem<String>> createDropdownTypeItems(
  List<AdminTypeModel> list,
) {
  List<String> listNameType = [];
  list.map((value) => {
        listNameType.add(value.title),
      });

  return listNameType.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }).toList();
}
