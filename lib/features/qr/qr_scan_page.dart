import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({super.key});

  Future<void> scan(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final scanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
    final inputImage = InputImage.fromFilePath(image.path);
    final codes = await scanner.processImage(inputImage);

    if (codes.isEmpty) return;

    final parts = codes.first.rawValue!.split('|');
    final inviteeId = parts[1];

    final ref = FirebaseFirestore.instance.collection('invitees').doc(inviteeId);
    final doc = await ref.get();

    if (doc.exists && doc['isUsed'] == false) {
      await ref.update({'isUsed': true, 'entryTime': Timestamp.now()});
      showDialog(context: context, builder: (_) => const AlertDialog(title: Text('Entry Allowed')));
    } else {
      showDialog(context: context, builder: (_) => const AlertDialog(title: Text('Entry Denied')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => scan(context),
          child: const Text('Scan QR'),
        ),
      ),
    );
  }
}
