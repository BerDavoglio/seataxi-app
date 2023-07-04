// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum AuthStatus {
  Login,
  Signup,
}

class _LoginPageState extends State<LoginPage> {
  AuthStatus _authStatus = AuthStatus.Login;
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      try {
        await Provider.of<LoginProvider>(
          context,
          listen: false,
        ).submitLogin(context, email, password);
      } catch (error) {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Page Error!'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } finally {
        FocusScope.of(context).unfocus();

        setState(() => _isLoading = false);
      }
    }
  }

  void _switch() {
    if (_authStatus == AuthStatus.Login) {
      setState(() {
        _authStatus = AuthStatus.Signup;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    color: Color.fromRGBO(242, 159, 5, 1),
                  ),
                  width: 350,
                  height: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          bottom: 35,
                        ),
                        child: Image.asset("images/seataxi-logo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe um Email Válido.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) =>
                                    setState(() => email = value!),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe uma Senha Válida.';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                onSaved: (value) =>
                                    setState(() => password = value!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.green,
                                    ),
                                  ),
                                  child: Text('Enter'.toUpperCase()),
                                  onPressed: () {
                                    _submit();
                                  },
                                ),
                              ),
                              TextButton.icon(
                                label: Text(
                                  _authStatus == AuthStatus.Login ? "REGISTRAR" : 'ENTRAR',
                                ),
                                icon: const Icon(Icons.person),
                                onPressed: () {
                                  _switch();
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
