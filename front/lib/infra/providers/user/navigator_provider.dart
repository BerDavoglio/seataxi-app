// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class NavigatorProvider with ChangeNotifier {
  late NavigatorConfigModel _navigatorConfig;
  NavigatorConfigModel get navigatorConfig => _navigatorConfig;

  Future<void> createNavigator(
      BuildContext context, NavigatorConfigModel newModel) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response =
          await http.post(Uri.parse('${Constants.BACKEND_BASE_URL}/navigator/'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${loginProvider.token}',
              },
              body: jsonEncode(newModel));

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Navegador. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> showNavigator(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/navigator/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _navigatorConfig = jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Navegador. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updateNavigator(
    BuildContext context,
    NavigatorConfigModel newNavigator,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/navigator/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newNavigator),
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
        await loginProvider.requestPerfil(context);
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

  Future<void> comumDialog(
      BuildContext context, String title, String content, Function func) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: func(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
