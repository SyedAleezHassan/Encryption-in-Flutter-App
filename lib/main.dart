import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EncryptDecryptPage(),
    );
  }
}

class EncryptDecryptPage extends StatefulWidget {
  @override
  _EncryptDecryptPageState createState() => _EncryptDecryptPageState();
}

class _EncryptDecryptPageState extends State<EncryptDecryptPage> {
  final TextEditingController _controller = TextEditingController();
  String _encryptedMessage = '';
  String _decryptedMessage = '';

  final encrypt.Key _key =
      encrypt.Key.fromUtf8('my 32 length key..................');
  final encrypt.IV _iv = encrypt.IV.fromLength(16);
  final encrypt.Encrypter _encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8('my 32 length key..................')));

  void _encryptMessage() {
    final encrypted = _encrypter.encrypt(_controller.text, iv: _iv);
    setState(() {
      _encryptedMessage = encrypted.base64;
    });
  }

  void _decryptMessage() {
    final decrypted = _encrypter.decrypt64(_encryptedMessage, iv: _iv);
    setState(() {
      _decryptedMessage = decrypted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encrypt & Decrypt Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration:
                  InputDecoration(labelText: 'Enter message to encrypt'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _encryptMessage,
              child: Text('Encrypt'),
            ),
            SizedBox(height: 16),
            Text('Encrypted Message: $_encryptedMessage'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _decryptMessage,
              child: Text('Decrypt'),
            ),
            SizedBox(height: 16),
            Text('Decrypted Message: $_decryptedMessage'),
          ],
        ),
      ),
    );
  }
}
