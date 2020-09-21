import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {

bool statusRedEye =true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
  
                  child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            buildContainer(), 
            buildText(), 
            buildContainerTextF(),
            buildContainerTextFPass(),
              ],
          ),
        ),
    );
  }
  

  Container buildContainerTextF() =>  Container(margin: EdgeInsets.only(top:26),
    width: 250,child: TextField(
    decoration: InputDecoration(labelText: 'User Name',
    border: OutlineInputBorder()),
    )
    );

   Container buildContainerTextFPass() =>  Container(margin: EdgeInsets.only(top:26),
    width: 250,child: TextField(obscureText: true,
    decoration: InputDecoration(labelText: 'Pass Word',
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              }),
    ),
    //suff
    )
    );

  Text buildText() => Text(
        'PWA My Team',
        style: GoogleFonts.rubik(
            textStyle: TextStyle(
          //fontWeigh:FontWeight.bold,
          fontSize: 30,
          color: Colors.pink.shade700,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        )),
      );

  Container buildContainer() {
    return Container(width: 180, child: Image.asset('images/logo.png'));
  }
}
