import 'package:event_checkin/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const InviteScanApp());
}

class InviteScanApp extends StatelessWidget {
  const InviteScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InviteScan',
      theme: ThemeData(useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
