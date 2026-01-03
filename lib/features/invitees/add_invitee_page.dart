import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddInviteePage extends StatelessWidget {
  final String eventId;
  AddInviteePage({super.key, required this.eventId});

  final nameCtrl = TextEditingController();

  Future<void> addInvitee(BuildContext context) async {
    final id = const Uuid().v4();
    await FirebaseFirestore.instance.collection('invitees').doc(id).set({
      'eventId': eventId,
      'name': nameCtrl.text,
      'isUsed': false,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Invitee')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Invitee Name')),
            ElevatedButton(onPressed: () => addInvitee(context), child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
