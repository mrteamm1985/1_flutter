import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/model/usermodel.dart';
import 'package:hello/widget/authen.dart';
import 'package:hello/widget/list_friend.dart';
import 'package:hello/widget/read_qr.dart';
import 'package:hello/widget/show_or.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String uidLogin, email;
  UserModel userModel;
  Widget currentWidget;
  List<String> title = ['List', 'Show Qr', 'Read Qr'];
  int indexTitle=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLogin();
  }

  Future<Null> findLogin() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      uidLogin = event.uid;
      email = event.email;
      print('uid=$uidLogin');
      findDetailLogin();
    });
  }

  Future<Null> findDetailLogin() async {
    await FirebaseFirestore.instance
        .collection('UserTeam')
        .doc(uidLogin)
        .snapshots()
        .listen((event) {
      //  print('event = ${event.toString()}');
      setState(() {
        userModel = UserModel.fromJson(event.data());
      });
      // print('name = ${userModel.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[indexTitle]),
        //title: Text('ss'),
      ),
      drawer: buildDrawer(),
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTile1(),
              buildListTile2(),
              buildListTile3(),
            ],
          ),
          buildColumnSingOut(),
        ],
      ),
    );
  }

  ListTile buildListTile1() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ListFriend();
          indexTitle = 0;
        });
      },
      leading: Icon(
        Icons.filter_1,
        size: 36,
      ),
      title: Text('List Friend'),
      subtitle: Text('แสดงรายชื่อของ เพื่อนเรา'),
    );
  }

  ListTile buildListTile2() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowQr(uid: uidLogin,);
          indexTitle = 1;
        });
      },
      leading: Icon(
        Icons.filter_2,
        size: 36,
      ),
      title: Text('Show QR code'),
      subtitle: Text('แสดง QR code'),
    );
  }

  ListTile buildListTile3() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ReadQr();
          indexTitle = 2;
        });
      },
      leading: Icon(
        Icons.filter_3,
        size: 36,
      ),
      title: Text('Read QR Code'),
      subtitle: Text('อ่าน QR Code'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/wall.jpg'), fit: BoxFit.cover)),
        accountName: Text(userModel == null ? 'Name' : userModel.name),
        accountEmail: Text(userModel == null ? 'Position' : userModel.position),
        currentAccountPicture: userModel == null
            ? Image.asset('images/avatar.png')
            : CircleAvatar(
                backgroundImage: NetworkImage(userModel.path),
              )
        // accountEmail: Text(email==null ? 'Email' :email),
        );
  }

  Column buildColumnSingOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red.shade700),
          child: ListTile(
            onTap: () {
              processSingOut();
            },
            leading: Icon(
              Icons.exit_to_app,
              size: 36,
              color: Colors.white,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> processSingOut() async {
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Authen(),
              ),
              (route) => false),
        );
  }
}
