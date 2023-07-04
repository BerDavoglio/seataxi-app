import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../ui.dart';

class AdminTrainingCrudPage extends StatefulWidget {
  final NavigatorTrainingModel? object;
  const AdminTrainingCrudPage({super.key, this.object});

  @override
  State<AdminTrainingCrudPage> createState() => _AdminTrainingCrudPageState();
}

class _AdminTrainingCrudPageState extends State<AdminTrainingCrudPage> {
  late NavigatorTrainingModel _object;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  void initState() {
    _object = widget.object!;

    _titleController.text = _object.title;
    _descriptionController.text = _object.description;
    _linkController.text = _object.link;

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
          'Criar/Editar Treinamentos',
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
                        icon: Icon(Icons.title_outlined),
                        labelText: 'Título',
                      ),
                      controller: _titleController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.video_label_outlined),
                        labelText: 'Descrição',
                      ),
                      controller: _descriptionController,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.video_camera_front_outlined),
                        labelText: 'Link',
                      ),
                      controller: _linkController,
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
