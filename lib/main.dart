import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipmart/src/config/di/injections.dart';
import 'package:zipmart/src/config/router/app_router_config.dart';
import 'package:zipmart/src/core/styles/app_theme.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
      ],
      child: MaterialApp.router(
        title: 'ZipMart',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouterConfig.router,
      ),
    );
  }
}
