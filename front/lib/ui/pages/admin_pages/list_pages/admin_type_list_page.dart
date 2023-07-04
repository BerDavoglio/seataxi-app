import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminTypeListPage extends StatefulWidget {
  const AdminTypeListPage({super.key});

  @override
  State<AdminTypeListPage> createState() => _AdminTypeListPageState();
}

class _AdminTypeListPageState extends State<AdminTypeListPage> {
  final List<AdminTypeModel> _listData = [
    const AdminTypeModel(
      id: 1,
      title: 'Barco 1',
      description:
          'Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!',
      people: '20',
    ),
    const AdminTypeModel(
      id: 2,
      title: 'Barco 1',
      description:
          'Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!',
      people: '20',
    ),
    const AdminTypeModel(
      id: 4,
      title: 'Barco 1',
      description:
          'Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!Descrição totalmente completa do tipo de barco!',
      people: '20',
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
          'Lista de Tipos de Barcos',
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
                height: 150,
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
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                _listData[index].description,
                              ),
                            ),
                            Text(
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                              'Pessoas: ${_listData[index].people}',
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
                                builder: (context) => AdminBoatTypeCrudPage(
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
              builder: (context) => const AdminBoatTypeCrudPage(
                object: AdminTypeModel(
                  id: 0,
                  title: '',
                  description: '',
                  people: '',
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
