// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class BoattypeProvider with ChangeNotifier {
  late List<AdminTypeModel> _boatType;
  List<AdminTypeModel> get boatType => _boatType;

  Future<void> createBoattype(
    BuildContext context,
    AdminTypeModel newBoattype,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/boattype/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newBoattype),
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

  Future<void> indexBoattype(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/boattype/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _boatType = jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Tipo de Embarcação. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future showBoattype(BuildContext context, int i) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/$i/boattype/'),
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Tipo de Embarcação. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updateBoattype(
    BuildContext context,
    AdminTypeModel newBoattype,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse(
            '${Constants.BACKEND_BASE_URL}/crud/boattype/${newBoattype.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newBoattype),
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

  Future<void> deleteBoattype(
    BuildContext context,
    int i,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/boattype/$i'),
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
