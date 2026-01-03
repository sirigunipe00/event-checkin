import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateEventPage extends StatelessWidget {
  CreateEventPage({super.key});

  final typeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  Future<void> saveEvent(BuildContext context) async {
    await FirebaseFirestore.instance.collection('events').add({
      'type': typeCtrl.text,
      'location': locationCtrl.text,
      'organizerId': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': Timestamp.now(),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: typeCtrl, decoration: const InputDecoration(labelText: 'Event Type')),
            TextField(controller: locationCtrl, decoration: const InputDecoration(labelText: 'Location')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => saveEvent(context), child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
