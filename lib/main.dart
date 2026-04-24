import 'package:flutter/material.dart';
import 'package:zipmart/src/core/styles/app_theme.dart';
import 'package:zipmart/src/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZipMart',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
