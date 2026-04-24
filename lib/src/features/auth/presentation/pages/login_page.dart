import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/validators.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/core/widgets/k_rich_text.dart';
import 'package:zipmart/src/features/auth/domain/entities/user_entity.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

import '../widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLoginPressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = UserEntity(
      email: _emailController.text,
      password: _passwordController.text,
    );
    context.read<AuthBloc>().add(AuthLogin(user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthStatus && current.isLoggedIn,
      listener: (context, state) {
        context.go(AppRoutes.dashboard);
      },
      child: Scaffold(
        backgroundColor: AppColors.blue,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          toolbarHeight: 0,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      buildHeader(context),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                vSpace40,
                                Text(
                                  "Let's Get Started",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                vSpace4,
                                Text(
                                  'Login to your account',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.grey),
                                ),
                                vSpace40,
                                KTextField(
                                  controller: _emailController,
                                  hintText: 'Email Address',
                                  validator: InputValidator.email,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                vSpace16,
                                KTextField(
                                  isPassword: true,
                                  hintText: 'Password',
                                  controller: _passwordController,
                                  validator: InputValidator.password,
                                ),
                                vSpace8,
                                buildForgotPasswordBtn(context),
                                vSpace20,
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return KFilledButton(
                                      text: 'Login',
                                      isLoading: state is AuthLoading,
                                      onPressed: state is AuthLoading
                                          ? null
                                          : onLoginPressed,
                                    );
                                  },
                                ),
                                const Spacer(),
                                KRichText(
                                  text1: "Don't have an account? ",
                                  text2: "Sign Up",
                                  padding: const EdgeInsets.only(bottom: 8),
                                  onTap: () {},
                                ),
                                vSpace16,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded buildHeader(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ZipMart',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Why wait? Just Zip it.',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildForgotPasswordBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot Password?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
        ),
      ),
    );
  }
}
