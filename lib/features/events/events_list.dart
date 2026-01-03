import 'package:event_checkin/features/events/create_event.dart';
import 'package:event_checkin/features/invitees/invitee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEventPage())),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['type']),
                subtitle: Text(doc['location']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InviteeListPage(eventId: doc.id)),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
