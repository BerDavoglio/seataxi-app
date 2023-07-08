import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/data.dart';
import '../../../../infra/infra.dart';
import '../../../ui.dart';

class AdminMaritmeListPage extends StatefulWidget {
  const AdminMaritmeListPage({super.key});

  @override
  State<AdminMaritmeListPage> createState() => _AdminMaritmeListPageState();
}

class _AdminMaritmeListPageState extends State<AdminMaritmeListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaritmebaseProvider maritmebaseProvider = Provider.of(context);

    List<AdminMaritmeModel> list = maritmebaseProvider.maritmebasePublicList;

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
          itemCount: list.length,
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
                                list[index].title,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                '${list[index].lat} / ${list[index].long}',
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
                                  object: list[index],
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
                              await maritmebaseProvider.deleteMaritmebase(
                                context,
                                list[index].id,
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
              builder: (context) => const AdminMaritmeBaseCrudPage(
                object: AdminMaritmeModel(
                  id: 0,
                  title: '',
                  lat: 0,
                  long: 0,
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
