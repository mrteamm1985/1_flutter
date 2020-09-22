import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //get border => null;

  List<String> positions = [
    'Users',
    'SA',
    'Front End',
    'Back End',
    'Full Stack'
  ];
  String choosePosition;
  double lat,lng;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade700,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            buildContainerAvatar(),
            buildContainerName(),
            buildSizedBox(),
            buildContainerDDL(),
            buildSizedBox(),
            buildContainerUser(),
            buildSizedBox(),
            buildContainerPass(),
            buildSizedBox(),
            buildContainerMAP(),
          ]),
        ));
  }

  Container buildContainerMAP() => Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        color: Colors.grey,
      );

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 16,
    );
  }

  Container buildContainerDDL() => Container(
        width: 250,
        child: DropdownButton<String>(
          items: positions
              .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          value: choosePosition,
          hint: Text('Position'),
          onChanged: (value) {
            setState(() {
              choosePosition = value;
            });
          },
        ),
      );

  Container buildContainerName() {
    return Container(
        width: 250,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Display Ur Name',
            prefixIcon: Icon(Icons.face, color: Color(0xffe81ee8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ));
  }

  Container buildContainerUser() {
    return Container(
        width: 250,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'User Name',
            prefixIcon: Icon(Icons.account_box, color: Color(0xffe81ee8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ));
  }

  Container buildContainerPass() {
    return Container(
        width: 250,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Ur Password',
            prefixIcon: Icon(Icons.keyboard, color: Color(0xffe81ee8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ));
  }

  Container buildContainerAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
          Container(
            width: 180,
            height: 180,
            child: Image.asset('images/avatar.png'),
          ),
          IconButton(icon: Icon(Icons.add_photo_alternate), onPressed: null),
        ],
      ),
    );
  }
}
