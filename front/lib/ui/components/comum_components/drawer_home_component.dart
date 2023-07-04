import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../ui.dart';

Drawer homeDrawer(BuildContext context) {
  LoginProvider loginProvider = Provider.of(context);

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 58, 89, 1),
            image: DecorationImage(
              image: AssetImage("images/seataxi-logo.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Text(''),
        ),
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.home_outlined),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.HOME);
          },
        ),
        const Divider(),
        if (loginProvider.perfil.role != 'admin')
          Column(
            children: [
              ListTile(
                title: const Text('Perfil'),
                leading: const Icon(Icons.person_outline),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.PERFIL);
                },
              ),
              ListTile(
                title: const Text('Histórico'),
                leading: const Icon(Icons.history_outlined),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.HISTORY);
                },
              ),
            ],
          ),
        if (loginProvider.perfil.role == 'navigator')
          Column(children: [
            ListTile(
              title: const Text('Treinamentos'),
              leading: const Icon(Icons.play_arrow_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.NAVTRAINING);
              },
            ),
          ]),
        if (loginProvider.perfil.role == 'admin')
          Column(
            children: [
              ListTile(
                title: const Text('Lista Navegadores'),
                leading: const Icon(Icons.directions_boat_outlined),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ADMLISTNAVIGATORS);
                },
              ),
              ListTile(
                title: const Text('Lista Treinamentos'),
                leading: const Icon(Icons.play_arrow_outlined),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ADMLISTTRAINING);
                },
              ),
              ListTile(
                title: const Text('Lista Bases Marítmas'),
                leading: const Icon(Icons.local_activity_outlined),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ADMLISTMARITMEBASE);
                },
              ),
              ListTile(
                title: const Text('Lista Barcos'),
                leading: const Icon(Icons.directions_boat_filled_outlined),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ADMLISTTYPE);
                },
              ),
            ],
          ),
        const Divider(),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.LOGIN);
          },
        ),
      ],
    ),
  );
}
