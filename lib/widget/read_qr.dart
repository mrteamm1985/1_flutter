import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class ReadQr extends StatefulWidget {
  @override
  _ReadQrState createState() => _ReadQrState();
}

class _ReadQrState extends State<ReadQr> {
  String qrResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => processQr(),
          child: Icon(Icons.add),
        ),
        body: Center(child: Text('Read Qr')));
  }

  Future<Null> processQr() async {
    try {
      var result = await BarcodeScanner.scan();
      qrResult = result.rawContent;
      print('Qr=$qrResult');
    } catch (e) {}
  }
}
