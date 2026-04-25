import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(CupertinoIcons.arrow_left),
        ),
        title: Text('Profile', style: TextStyle(fontSize: 18)),
        titleSpacing: 0,
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.blue,
                  child: Icon(
                    CupertinoIcons.person_fill,
                    color: AppColors.white,
                  ),
                ),
                hSpace12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mock User',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'mockuser@gmail.com',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),

            KFilledButton(
              text: 'Logout',
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
