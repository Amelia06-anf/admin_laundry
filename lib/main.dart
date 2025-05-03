import 'package:admin_laudry/pages/laporanPage.dart';
import 'package:admin_laudry/pages/login.dart';
import 'package:admin_laudry/pages/register.dart';
import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';

void main() {
  runApp(const DashboardAdminApp());
}

class DashboardAdminApp extends StatelessWidget {
  const DashboardAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Admin',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
