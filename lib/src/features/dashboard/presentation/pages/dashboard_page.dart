import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_header.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.email});

  final String? email;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthStatus && !current.isLoggedIn,
      listener: (context, state) {
        context.go(AppRoutes.login);
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            DashboardHeader(),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  title: Text(
                    'Item $index',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }, childCount: 20),
            ),
          ],
        ),
      ),
    );
  }
}
