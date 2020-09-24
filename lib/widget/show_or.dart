import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQr extends StatefulWidget {
  final String uid;
  ShowQr({Key key, this.uid}) : super(key: key);
  @override
  _ShowQrState createState() => _ShowQrState();
}

class _ShowQrState extends State<ShowQr> {
  String uidLogin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uidLogin = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: QrImage(data: uidLogin),
        ),
      ),
    );
  }
}
