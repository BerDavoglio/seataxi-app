import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminMaritmeListPage extends StatefulWidget {
  const AdminMaritmeListPage({super.key});

  @override
  State<AdminMaritmeListPage> createState() => _AdminMaritmeListPageState();
}

class _AdminMaritmeListPageState extends State<AdminMaritmeListPage> {
  final List<AdminMaritmeModel> _listData = [
    const AdminMaritmeModel(
      id: 1,
      title: 'Base 1',
      coordLat: '31.438792',
      coordLong: '3,32871394821',
    ),
    const AdminMaritmeModel(
      id: 2,
      title: 'Base 2',
      coordLat: '31.438792',
      coordLong: '3,32871394821',
    ),
    const AdminMaritmeModel(
      id: 3,
      title: 'Base 3',
      coordLat: '31.438792',
      coordLong: '3,32871394821',
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
          'Lista de Bases Marítmas',
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
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                _listData[index].title,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                '${_listData[index].coordLat} / ${_listData[index].coordLong}',
                              ),
                            ),
                          ],
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
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(100, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.yellow,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminMaritmeBaseCrudPage(
                                  object: _listData[index],
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Editar',
                            style: TextStyle(
                              fontSize: 24,
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
                            'Apagar',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.create_outlined,
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMaritmeBaseCrudPage(
                object: AdminMaritmeModel(
                  id: 0,
                  title: '',
                  coordLat: '',
                  coordLong: '',
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
