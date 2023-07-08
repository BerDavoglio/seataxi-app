import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

class NavigatorHomePage extends StatefulWidget {
  const NavigatorHomePage({super.key});

  @override
  State<NavigatorHomePage> createState() => _NavigatorHomePageState();
}

class _NavigatorHomePageState extends State<NavigatorHomePage> {
  int? _acceptTravelID;
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of(context);

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
            itemCount: tripProvider.tripList.length,
            itemBuilder: (BuildContext context, int index) {
              return navigatorHomeItem(
                tripProvider,
                index,
                () => setState(
                  () {
                    _acceptTravelID = tripProvider.tripList[index].id;
                  },
                ),
                () => setState(() {
                  tripProvider.tripList.removeWhere(
                      (item) => item.id == tripProvider.tripList[index].id);
                }),
              );
            },
          ),
          if (_acceptTravelID != null)
            navigatorHomeSendValue(
              context,
              _acceptTravelID,
              _valueController,
              () async {
                await tripProvider
                    .updateValue(
                  context,
                  _acceptTravelID!,
                  double.parse(_valueController.text),
                )
                    .then(
                  (value) async {
                    await tripProvider.indexTrip(
                      context,
                      _acceptTravelID!,
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
