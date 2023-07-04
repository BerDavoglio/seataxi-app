import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminMaritmeBaseCrudPage extends StatefulWidget {
  final AdminMaritmeModel? object;
  AdminMaritmeBaseCrudPage({super.key, this.object});

  @override
  State<AdminMaritmeBaseCrudPage> createState() =>
      _AdminMaritmeBaseCrudPageState();
}

class _AdminMaritmeBaseCrudPageState extends State<AdminMaritmeBaseCrudPage> {
  late AdminMaritmeModel _object;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _coordLatController = TextEditingController();
  final TextEditingController _coordLongController = TextEditingController();

  @override
  void initState() {
    _object = widget.object!;

    _titleController.text = _object.title;
    _coordLatController.text = _object.coordLat;
    _coordLongController.text = _object.coordLong;

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
          'Criar/Editar Bases Marítimas',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            height: 280,
            decoration: BoxDecoration(color: Colors.amber[500]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.near_me_outlined),
                        labelText: 'Título',
                      ),
                      controller: _titleController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.map_outlined),
                        labelText: 'Coordenada de Latitude',
                      ),
                      controller: _coordLatController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.map_outlined),
                        labelText: 'Coordenada de Longetude',
                      ),
                      controller: _coordLongController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green,
                        ),
                      ),
                      onPressed: () {
                        if (_object.id == 0) {
                          // Create a New One
                        } else {
                          // Update with _object.id
                        }
                      },
                      child: const Text(
                        'Finalizar',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
