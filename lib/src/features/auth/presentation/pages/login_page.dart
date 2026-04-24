import 'package:flutter/material.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/validators.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/core/widgets/k_rich_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(backgroundColor: AppColors.transparent, toolbarHeight: 0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
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
                                'Sign in to your account',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.grey),
                              ),
                              vSpace40,

                              KTextField(
                                controller: _emailController,
                                hintText: 'Email Address',
                                validator: InputValidator.email,
                                autovalidateMode: AutovalidateMode.onUnfocus,
                              ),
                              vSpace16,
                              KTextField(
                                isPassword: true,
                                hintText: 'Password',
                                controller: _passwordController,
                                validator: InputValidator.password,
                                autovalidateMode: AutovalidateMode.onUnfocus,
                              ),
                              vSpace8,

                              buildForgotPasswordBtn(context),
                              vSpace20,
                              KFilledButton(text: 'Sign In', onPressed: () {}),

                              Spacer(),
                              KRichText(
                                text1: "Don't have an account? ",
                                text2: "Sign Up",
                                padding: EdgeInsets.only(bottom: 8),
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
