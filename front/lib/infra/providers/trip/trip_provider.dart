// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';
import '../../infra.dart';

class TripProvider with ChangeNotifier {
  late TripModel? _trip;
  late List<TripModel> _tripList;

  TripModel? get trip => _trip;
  List<TripModel> get tripList => _tripList;

  Future<void> createTrip(
    BuildContext context,
    CreateTripModel newTrip,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode(newTrip),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _trip = v;
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

  Future<void> indexTripsNavigator(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/navigator/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        _tripList = jsonDecode(response.body);
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
        '',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> updateValue(
    BuildContext context,
    int id,
    double val,
  ) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/value/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
        body: jsonEncode({
          'value': val,
        }),
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

  Future getValue(BuildContext context, int id) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/value/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 269) {
        return null;
      } else if (response.statusCode == 200) {
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
        '',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> denyUser(BuildContext context, int id) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/value/$id/deny'),
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

  Future<void> updateAccept(BuildContext context, int id) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/accept/$id'),
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

  Future getAccept(BuildContext context, int i) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/accept/$i/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 269) {
        return null;
      } else if (response.statusCode == 200) {
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
        '',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future<void> finishTrip(BuildContext context, int id) async {
    LoginProvider loginProvider = Provider.of(context);
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/finish/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _trip = null;
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

  Future indexTrip(BuildContext context, int id) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        notifyListeners();
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
        '',
        () => {
          Navigator.of(context).pop(),
          notifyListeners(),
        },
      );
    }
  }

  Future indexTripsUser(BuildContext context) async {
    LoginProvider loginProvider = Provider.of(context);

    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/trip/user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginProvider.token}',
        },
      );

      if (response.statusCode == 200) {
        notifyListeners();
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
        '',
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
