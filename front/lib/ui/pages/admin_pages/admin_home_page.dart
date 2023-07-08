import 'package:flutter/material.dart';

import '../../ui.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

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
            'SeaTaxi',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.ADMLISTTRIPS);
                      },
                      child: const Text(
                        'LISTAGEM DE VIAGENS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.ADMLISTNAVIGATORS);
                      },
                      child: const Text(
                        'NAVEGADORES',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.ADMLISTTRAINING);
                      },
                      child: const Text(
                        'TREINAMENTOS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.ADMLISTMARITMEBASE);
                      },
                      child: const Text(
                        'BASES MARITIMAS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.ADMLISTTYPE);
                      },
                      child: const Text(
                        'TIPOS DE EMBARCAÇÕES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
