// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class TreineeProvider with ChangeNotifier {
  late List<NavigatorTrainingModel> _treineeList;
  List<NavigatorTrainingModel> get treineeList => _treineeList;

  Future<void> createTreinee(
    BuildContext context,
    NavigatorTrainingModel newTreinee,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/treinee/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newTreinee),
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

  Future<void> indexTreinee(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/treinee/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _treineeList = jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Treinamento. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future showTreinee(BuildContext context, int i) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/$i/treinee/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Treinamento. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updateTreinee(
    BuildContext context,
    NavigatorTrainingModel newTreinee,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse(
            '${Constants.BACKEND_BASE_URL}/crud/treinee/${newTreinee.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newTreinee),
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

  Future<void> deleteTreinee(
    BuildContext context,
    int i,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/treinee/$i'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
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
