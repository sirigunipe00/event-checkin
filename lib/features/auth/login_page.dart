import 'package:event_checkin/features/events/events_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> login(BuildContext context) async {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const EventListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => login(context),
          child: const Text('Login as Organizer'),
        ),
      ),
    );
  }
}
