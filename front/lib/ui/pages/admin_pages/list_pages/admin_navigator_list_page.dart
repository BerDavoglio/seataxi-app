import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminNavigatorListPage extends StatefulWidget {
  const AdminNavigatorListPage({super.key});

  @override
  State<AdminNavigatorListPage> createState() => _AdminNavigatorListPageState();
}

class _AdminNavigatorListPageState extends State<AdminNavigatorListPage> {
  final List<NavigatorsAcceptanceModel> _listData = [
    const NavigatorsAcceptanceModel(
      id: 1,
      name: 'Omaoa',
      email: 'omaoa@gmail.com',
      photo:
          'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg',
    ),
    const NavigatorsAcceptanceModel(
      id: 2,
      name: 'Omaoa',
      email: 'omaoFLKJHDSBJKIGHDFSKJa@gmail.com',
      photo:
          'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg',
    ),
    const NavigatorsAcceptanceModel(
      id: 3,
      name: 'Omaoa',
      email: 'omaoa@gmail.com',
      photo:
          'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

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
          'Navegadores Pendentes',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    width: 300,
                    height: 120,
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 35, // Image radius
                              backgroundImage:
                                  NetworkImage(_listData[index].photo),
                            )),
                        SizedBox(
                          width: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _listData[index].name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  _listData[index].email,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                // Fazer a requisição de aceitação
                              },
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _listData.removeWhere(
                                      (item) => item.id == _listData[index].id);
                                });
                              },
                              child: const Text(
                                'Negar',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
