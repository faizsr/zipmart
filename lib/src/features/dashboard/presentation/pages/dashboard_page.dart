import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthStatus && !current.isLoggedIn,
      listener: (context, state) {
        context.go(AppRoutes.login);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                    size: 36,
                  ),
                ),
                vSpace20,
                Text(
                  'You are logged in',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                vSpace8,
                Text(
                  email == null || email!.isEmpty
                      ? 'Your mocked session is active.'
                      : 'Signed in as $email',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.grey),
                ),
                vSpace24,
                KFilledButton(
                  text: 'Log Out',
                  width: 220,
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
