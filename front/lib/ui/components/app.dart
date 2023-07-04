import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infra/infra.dart';
import '../ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TripProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TreineeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MaritmebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BoattypeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(22, 58, 89, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(217, 217, 217, 1),
          ),
        ),
        routes: {
          AppRoutes.LOGIN: (_) => const LoginPage(),
          AppRoutes.HOME: (_) => const AuthOrHomeScreen(),
          AppRoutes.IDLE: (_) => const IdleHomePage(),
          AppRoutes.PERFIL: (_) => const PerfilPage(),
          AppRoutes.HISTORY: (_) => const HistoryPage(),
          AppRoutes.NAVHOME: (_) => const NavigatorHomePage(),
          AppRoutes.NAVROUTE: (_) => const NavigatorRoutePage(),
          AppRoutes.NAVTRAINING: (_) => const NavigatorTrainingPage(),
          AppRoutes.ADMHOME: (_) => const AdminHomePage(),
          AppRoutes.ADMLISTNAVIGATORS: (_) => const AdminNavigatorListPage(),
          AppRoutes.ADMLISTTRAINING: (_) => const AdminTrainingListPage(),
          AppRoutes.ADMLISTMARITMEBASE: (_) => const AdminMaritmeListPage(),
          AppRoutes.ADMLISTTYPE: (_) => const AdminTypeListPage(),
          AppRoutes.ADMTRAINING: (_) => const AdminTrainingCrudPage(),
          AppRoutes.ADMMARITMEBASECRUD: (_) => const AdminMaritmeBaseCrudPage(),
          AppRoutes.ADMBOATTYPECRUD: (_) => const AdminBoatTypeCrudPage(),
        },
      ),
    );
  }
}
