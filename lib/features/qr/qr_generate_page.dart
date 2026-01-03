import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratePage extends StatelessWidget {
  final String inviteeId;
  final String eventId;

  const QRGeneratePage({super.key, required this.inviteeId, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: Center(
        child: QrImageView(
          data: '$eventId|$inviteeId',
          size: 250,
        ),
      ),
    );
  }
}
