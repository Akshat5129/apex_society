import 'dart:convert';

import 'package:apex_society/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class SchemeAcc extends StatefulWidget {
  const SchemeAcc({Key? key}) : super(key: key);

  @override
  State<SchemeAcc> createState() => _SchemeAccState();
}

class _SchemeAccState extends State<SchemeAcc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(child: Icon(Icons.arrow_back),
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            HomeScreen()
                          ,),);
                      }
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Scheme Accounts",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: .2,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),],),


      bottomSheet:  Container(
        height: 49,
        color: Color.fromRGBO(80, 109, 138, 1),
      ),
    );
  }
}
