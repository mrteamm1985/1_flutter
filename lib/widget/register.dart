import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello/utility/normal_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

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
  String choosePosition, name, user, password;
  double lat, lng;
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocation();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
      print('lat = $lat,lng = $lng');
    });
  }

  Future<LocationData> findLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      print('e Findlocation ==> ${e.toString()}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.cloud_upload), onPressed: () => uploadImage()),
          ],
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
            lat == null ? CircularProgressIndicator() : buildContainerMAP(),
          ]),
        ));
  }

  Set<Marker> mySet() {
    return <Marker>[
      Marker(
          markerId: MarkerId('myID'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'U R Here',
            snippet: 'Lat : $lat, Long : $lng',
          ))
    ].toSet();
  }

  Container buildContainerMAP() {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16,
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mySet(),
      ),
    );
  }

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
          onChanged: (value) => name = value.trim(),
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
          onChanged: (value) => user = value.trim(),
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
          onChanged: (value) => password = value.trim(),
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

  Future<Null> chooseAvatar(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Container buildContainerAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseAvatar(ImageSource.camera),
          ),
          Container(
            width: 180,
            height: 180,
            child: file == null
                ? Image.asset('images/avatar.png')
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseAvatar(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<Null> uploadImage() async {
    print('name= $name usere =$user password=$password');
    if (file == null) {
      normalDialog(context, 'Pls choose Avatar');
    } else if (name == null ||
        name.isEmpty ||
        user == null ||
        user.isEmpty ||
        password == null ||
        password.isEmpty) {
      normalDialog(context, 'Pls กรอกข้อมูลให้ครบนะครับ ไม่เอาค่าว่าง');
    }else if (choosePosition==null) {
      normalDialog(context, 'Pls กรอกข้อมูลให้ครบนะครับ Position');
    }else{
        
    }
  }
}
