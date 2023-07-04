import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminBoatTypeCrudPage extends StatefulWidget {
  final AdminTypeModel? object;
  const AdminBoatTypeCrudPage({super.key, this.object});

  @override
  State<AdminBoatTypeCrudPage> createState() => _AdminBoatTypeCrudPageState();
}

class _AdminBoatTypeCrudPageState extends State<AdminBoatTypeCrudPage> {
  late AdminTypeModel _object;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();

  @override
  void initState() {
    _object = widget.object!;

    _nameController.text = _object.title;
    _descriptionController.text = _object.description;
    _peopleController.text = _object.people;

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
          'Criar/Editar',
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
                        icon: Icon(Icons.directions_boat_filled_outlined),
                        labelText: 'Nome',
                      ),
                      controller: _nameController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.description_outlined),
                        labelText: 'Descrição',
                      ),
                      controller: _descriptionController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.people_alt_outlined),
                        labelText: 'Número Máximo de Pessoas',
                      ),
                      controller: _peopleController,
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
