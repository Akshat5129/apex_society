import 'dart:convert';

import 'package:apex_society/second_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FirstLogin extends StatefulWidget {
  const FirstLogin({Key? key}) : super(key: key);

  @override
  State<FirstLogin> createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {

  TextEditingController controllerUserID = TextEditingController();

  Future<void> sendData() async {

    if(controllerUserID.text != ""){

    var headers = {
      'Content-Type': 'application/json',
      };
    var request =
    http.Request('POST', Uri.parse('http://mobileapp.parjinindiainfotech.in/api/Society/LoginSocCd'));

    request.body = json.encode({"SocCd": controllerUserID.text});

    request.headers.addAll(headers);
    print("req" + request.toString());
    print("body" + request.body);
    print("headers" + request.headers.toString());

    http.StreamedResponse response = await request.send();

    Map<String,dynamic> result = {};

    var res1;
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
    print("otp sent succesfully");

      result = jsonDecode(await response.stream.bytesToString()) as Map<String, dynamic>;

      if(result["result"][0]["societyCd"] == controllerUserID.text){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            SecondLogin(controllerUserID.text)
          ,),);
      }

    } else {
    print(response.reasonPhrase);
    print("failed");
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 250, 255, 1),
      body: Container(
          padding: EdgeInsets.all(50),
          child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    //Image.asset("assets/images/logo.png", width: 200),
                    SizedBox(height: 100,),
                    Text(
                      "Apex Society",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .2,
                            fontSize: 29,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Customer ID",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          letterSpacing: .2,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 6, top: 2, right: 6, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                        top: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                        right: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                        left: BorderSide(width: 1, color: Colors.lightBlue.shade900),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  margin: EdgeInsets.only(top: 15),
                                  child: TextField(
                                    controller: controllerUserID,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      //contentPadding: EdgeInsets.all(1),
                                      hintText: 'Enter your User ID',
                                      prefixIcon: Icon(Icons.person_rounded),
                                    ),
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.black54,
                                        letterSpacing: .2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                GestureDetector(child: Container(
                                  margin: EdgeInsets.only(top: 80),
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  width: double.infinity,
                                  child:  TextButton(
                                    child: Text('NEXT'),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color.fromRGBO(80, 109, 138, 1),
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      print('Pressed');

                                      sendData();



                                    },
                                  ),
                                ),),



                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ])
      ),
      bottomSheet:  Container(
        height: 59,
        color: Color.fromRGBO(80, 109, 138, 1),
      ),
    );
  }
}
