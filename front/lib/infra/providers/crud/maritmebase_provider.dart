// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class MaritmebaseProvider with ChangeNotifier {
  late List<AdminMaritmeModel> _maritmebasePublicList;
  List<AdminMaritmeModel> get maritmebasePublicList => _maritmebasePublicList;

  Future<void> createMaritmebase(
    BuildContext context,
    AdminMaritmeModel newMaritmebase,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/maritmebase/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newMaritmebase),
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

  Future<void> indexMaritmebase(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/maritmebase/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _maritmebasePublicList = jsonDecode(response.body);
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Base Marítima. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future showMaritmebase(BuildContext context, int i) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/$i/maritmebase/'),
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
        'Ocorreu um erro ao tentar obter os valores de configuração de Base Marítima. $e',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updateBoattype(
    BuildContext context,
    AdminMaritmeModel newMaritmebase,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse(
            '${Constants.BACKEND_BASE_URL}/crud/maritmebase/${newMaritmebase.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newMaritmebase),
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

  Future<void> deleteMaritmebase(
    BuildContext context,
    int i,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/crud/maritmebase/$i'),
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
}
