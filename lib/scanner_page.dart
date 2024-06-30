import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'reservation_page.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? fileName;
  TextEditingController addressController = TextEditingController();

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  void _submit() {
    String address = addressController.text;
    if (fileName != null ) {
      // Add logic here to submit the file and address to the server or perform other actions
      print('Adresse: $address');
      print('Nom du fichier: $fileName');
      // Navigate to ReservationScreen after submission
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservationScreen()),
      );
    } else {
      // Show an error message or alert if the file or address is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Veuillez télécharger un document')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner un document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'images/scan_icon.png', // Replace with your image path
              height: 150,
            ),
            SizedBox(height: 1),
            Text(
              'Scannez un document prouvant que vous êtes vétérinaire',
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      fileName ?? 'Téléchargez un document',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(
                    255, 86, 182, 129), // Background color of the button
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded border
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
