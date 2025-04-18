
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
      home: const DashboardPage(),
    );
  }
}
