import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../infra/infra.dart';
import '../../../ui.dart';

class AdminNavigatorListPage extends StatefulWidget {
  const AdminNavigatorListPage({super.key});

  @override
  State<AdminNavigatorListPage> createState() => _AdminNavigatorListPageState();
}

class _AdminNavigatorListPageState extends State<AdminNavigatorListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of(context);

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
            itemCount: loginProvider.navigators.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    width: 300,
                    height: 120,
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Row(
                      children: [
                        // Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: CircleAvatar(
                        //       radius: 35, // Image radius
                        //       backgroundImage:
                        //           NetworkImage(loginProvider.navigators[index].photo),
                        //     )),
                        SizedBox(
                          width: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                loginProvider.navigators[index].name,
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
                                  loginProvider.navigators[index].email,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(100, 100)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green,
                            ),
                          ),
                          onPressed: () async {
                            await loginProvider.confirmateNavigator(
                              context,
                              loginProvider.navigators[index].id,
                            );
                          },
                          child: const Text(
                            'Aceitar',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
