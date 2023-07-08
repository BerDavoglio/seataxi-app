import 'package:flutter/material.dart';
import 'package:front/infra/infra.dart';
import 'package:provider/provider.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminTypeListPage extends StatefulWidget {
  const AdminTypeListPage({super.key});

  @override
  State<AdminTypeListPage> createState() => _AdminTypeListPageState();
}

class _AdminTypeListPageState extends State<AdminTypeListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BoattypeProvider boattypeProvider = Provider.of(context);

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
          itemCount: boattypeProvider.boattypeList.length,
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
                                boattypeProvider.boattypeList[index].title,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                boattypeProvider
                                    .boattypeList[index].description,
                              ),
                            ),
                            Text(
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                              'Pessoas: ${boattypeProvider.boattypeList[index].people}',
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
                                  object: boattypeProvider.boattypeList[index],
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
                            setState(() async {
                              await boattypeProvider.deleteBoattype(
                                context,
                                boattypeProvider.boattypeList[index].id,
                              );
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
