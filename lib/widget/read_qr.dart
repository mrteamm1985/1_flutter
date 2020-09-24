import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello/model/usermodel.dart';
import 'package:hello/utility/normal_dialog.dart';
import 'package:hello/widget/constant.dart';

class ReadQr extends StatefulWidget {
  @override
  _ReadQrState createState() => _ReadQrState();
}

class _ReadQrState extends State<ReadQr> {
  String qrResult;
  // String qrResult = '5wJ1VvWEmjXxYNzNpk7SvB3G1Uk2';
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    // processQr();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => processQr(),
        child: Icon(Icons.add),
      ),
      body: qrResult == null ? Text('Pls click OR Code') : buildColumn(),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        Text('Name : ${userModel.name}'),
        Text('Posi : ${userModel.position}'),
        Text('lat : ${userModel.lat}'),
        Text('long : ${userModel.lng}'),
        Container(
          width: 200,
          height: 200,
          child: Image.network(userModel.path),
        ),
        Text('Read Qr'),
        buildOutlineButton()
      ],
    );
  }

  OutlineButton buildOutlineButton() => OutlineButton(
        onPressed: () => processUploadMysql(),
        child: Text('Upload Data to Mysql'),
      );

  Future<Null> processQr() async {
    try {
      var result = await BarcodeScanner.scan();
      // qrResult = result.rawContent;
      qrResult = '5wJ1VvWEmjXxYNzNpk7SvB3G1Uk2';
      print('Qr=$qrResult');
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('UserTeam')
            .doc(qrResult)
            .snapshots()
            .listen((event) {
          setState(() {
            userModel = UserModel.fromJson(event.data());
          });
        });
      });
    } catch (e) {}
  }

  Future<Null> processUploadMysql() async {
    String urlAPI =
        '${Contant().domin}/pwa/addFriend.php?isAdd=true&uidLogin=$qrResult&uidFriend=$qrResult&nameFriend=${userModel.name}&position=${userModel.position}&urlPath=${userModel.name}';
    //await Dio().get(urlAPI).then(value)=>normalDialog(context,'Sussss');
    await Dio().get(urlAPI).then((value) => normalDialog(context, 'Sussess'));
  }
}
