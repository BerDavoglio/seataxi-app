import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

Column sectionOne(
  MaritmebaseProvider maritmebaseProvider,
  String dropdownOrigin,
  String dropdownDestination,
  String dropdownPayment,
  Function changeOriginFunction,
  Function changeDestinationFunction,
  Function changePaymentFunction,
  List listPaymentMethod,
) {
  return Column(
    children: [
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
                  value: dropdownOrigin,
                  icon: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String? value) {
                    changeOriginFunction(value);
                  },
                  items: createDropdownCoordItems(
                      maritmebaseProvider.maritmebasePublicList),
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
                  value: dropdownDestination,
                  icon: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String? value) {
                    changeDestinationFunction(value);
                  },
                  items: createDropdownCoordItems(
                      maritmebaseProvider.maritmebasePublicList),
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
                  value: dropdownPayment,
                  icon: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String? value) {
                    changePaymentFunction(value);
                  },
                  items: createDrowpdownPaymentItems(listPaymentMethod),
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
