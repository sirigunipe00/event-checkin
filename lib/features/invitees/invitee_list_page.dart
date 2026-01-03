import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_invitee_page.dart';
import '../qr/qr_generate_page.dart';

class InviteeListPage extends StatelessWidget {
  final String eventId;

  const InviteeListPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitees'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddInviteePage(eventId: eventId),
            ),
          );
        },
        child: const Icon(Icons.person_add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('invitees')
            .where('eventId', isEqualTo: eventId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No invitees added yet'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: Icon(
                  data['isUsed'] == true ? Icons.check_circle : Icons.qr_code,
                  color: data['isUsed'] == true ? Colors.green : Colors.blue,
                ),
                title: Text(data['name'] ?? 'No Name'),
                subtitle: Text(
                  data['isUsed'] == true ? 'Entry Used' : 'Not Entered',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QRGeneratePage(
                          inviteeId: doc.id,
                          eventId: eventId,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
