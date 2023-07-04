// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool _editGeral = false;
  bool _editNav = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cellController = TextEditingController();

  final TextEditingController _boatMaritmeController = TextEditingController();
  final TextEditingController _boatTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of(context);
    NavigatorProvider navigatorProvider = Provider.of(context);

    _nameController.text = loginProvider.perfil.name;
    _emailController.text = loginProvider.perfil.email;
    _cepController.text = loginProvider.perfil.cep;
    _cpfController.text = loginProvider.perfil.cpf.toString();
    _cellController.text = loginProvider.perfil.cell.toString();

    _boatMaritmeController.text =
        navigatorProvider.navigatorConfig.maritme_base_id;
    _boatTypeController.text = navigatorProvider.navigatorConfig.boat_type_id;

    return Scaffold(
      drawer: homeDrawer(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        toolbarHeight: 70,
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: _editGeral ? 700 : 450,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          ),
                        ),
                        !_editGeral
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nome: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Text(
                                          loginProvider.perfil.name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'E-mail: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Text(
                                          loginProvider.perfil.email,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Endereço: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Text(
                                          loginProvider.perfil.cep,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'CPF/CNPJ: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${loginProvider.perfil.cpf}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Celular: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${loginProvider.perfil.cell}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: 'Nome',
                                      ),
                                      controller: _nameController,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.mail_outline),
                                        labelText: 'E-mail',
                                      ),
                                      controller: _emailController,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.cake_outlined),
                                        labelText: 'Data de Nacimento',
                                      ),
                                      controller: _birthController,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.home_outlined),
                                        labelText: 'Endereço',
                                      ),
                                      controller: _cepController,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                            Icons.insert_drive_file_outlined),
                                        labelText: 'CPF/CNPJ',
                                      ),
                                      controller: _cpfController,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        icon:
                                            Icon(Icons.phone_android_outlined),
                                        labelText: 'Celular',
                                      ),
                                      controller: _cellController,
                                    ),
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  Size(150, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                !_editGeral ? Colors.green : Colors.yellow,
                              ),
                            ),
                            onPressed: () {
                              setState(() => {
                                    _editGeral = !_editGeral,
                                    if (_editGeral)
                                      {
                                        // Enviar requisição de edição
                                      },
                                  });
                            },
                            child: Text(
                              !_editGeral ? 'Edit' : 'Finalizar',
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
                if (loginProvider.perfil.role == 'navigator')
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 350,
                      height: _editNav ? 290 : 250,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            !_editNav
                                ? Column(
                                    children: [
                                      Text(
                                        'Base Marítima:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tipo de Embarcação: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Expanded(
                                            child: Text(
                                              navigatorProvider.navigatorConfig
                                                  .maritme_base_id,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tipo de Embarcação: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Expanded(
                                            child: Text(
                                              navigatorProvider
                                                  .navigatorConfig.boat_type_id,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        color: Colors.amber,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.flag_circle_outlined),
                                            labelText: 'Base Marítima',
                                          ),
                                          controller: _boatMaritmeController,
                                        ),
                                      ),
                                      Container(
                                        color: Colors.amber,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons
                                                .directions_boat_filled_outlined),
                                            labelText: 'Tipo de Embarcação',
                                          ),
                                          controller: _boatTypeController,
                                        ),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(150, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    !_editNav ? Colors.green : Colors.yellow,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() => {
                                        _editNav = !_editNav,
                                        if (_editNav)
                                          {
                                            // Enviar requisição de edição
                                          },
                                      });
                                },
                                child: Text(
                                  !_editNav ? 'Edit' : 'Finalizar',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
