// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../ui/utils/utils.dart';
import '../../infra.dart';

class LoginProvider with ChangeNotifier {
  String _token = '';
  late UserModel _perfil;
  late List<UserModel> _navigators;

  String get token => _token;
  UserModel get perfil => _perfil;
  List<UserModel> get navigators => _navigators;

  bool get isAuth {
    return _token != '';
  }

  Future<void> submitLogin(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/jwt/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      var v = jsonDecode(response.body);

      if (v['token'] != '') {
        _token = v['token'];
        await requestPerfil(context);
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        notifyListeners();
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          jsonDecode(response.body)['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        'Coloque o e-mail e a senha corretos por gentileza. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> requestPerfil(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        _perfil = jsonDecode(response.body);
        notifyListeners();
      } else if (jsonDecode(response.body)['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          jsonDecode(response.body)['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        'Ocorreu um erro ao tentar obter os valores de perfil. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> requestNavigators(
      BuildContext context, bool onlyNotConfirmed) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.BACKEND_BASE_URL}/user/navigators/${onlyNotConfirmed ? 1 : 0}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        _navigators = jsonDecode(response.body);
        notifyListeners();
      } else if (jsonDecode(response.body)['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          jsonDecode(response.body)['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        'Ocorreu um erro ao tentar obter os valores de perfil. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updatePerfil(BuildContext context, UserModel newUser) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(newUser),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await comumDialog(
          context,
          'Usuário Atualizado',
          'Usuário atualizado com Sucesso!',
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
        await requestPerfil(context);
        Navigator.of(context).pop();
        notifyListeners();
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  // Update Pass

  Future<void> confirmateNavigator(BuildContext context, int id) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/confirmateNavigator/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await comumDialog(
          context,
          '',
          '',
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
        notifyListeners();
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
          () => {
            Navigator.of(context).pop(),
            notifyListeners(),
          },
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error!',
        e.toString(),
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }


  Future<void> logout() async {
    _token = '';

    notifyListeners();
  }
}
