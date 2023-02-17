import 'dart:convert';

import 'package:apex_society/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SecondLogin extends StatefulWidget {
  //const SecondLogin({Key? key}) : super(key: key);

  String userid,img_link,soc_name;

  @override
  State<SecondLogin> createState() => _SecondLoginState();

  SecondLogin(this.userid,this.img_link,this.soc_name);
}

class _SecondLoginState extends State<SecondLogin> {

  TextEditingController controllerUserID = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  Future<void> sendData() async {

    if(controllerUserID.text != ""){

      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
      http.Request('POST', Uri.parse('http://mobileapp.parjinindiainfotech.in/api/Member/GetMemberDetails'));

      request.body = json.encode({"SocietyCode": widget.userid,"UserName": controllerUserID.text,"Password": controllerPassword.text});

      request.headers.addAll(headers);
      print("req" + request.toString());
      print("body" + request.body);
      print("headers" + request.headers.toString());

      http.StreamedResponse response = await request.send();

      Map<String,dynamic> result = {};

      var res1;
      if (response.statusCode == 200) {
        print("otp sent succesfully");

        result = jsonDecode(await response.stream.bytesToString()) as Map<String, dynamic>;


        if(result["result"].length!=0){
          if(result["result"][0]["userName"] == controllerUserID.text) {
              if (result["result"][0]["userPassword"] == controllerPassword.text) {
                print("Userid and password matched");
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    HomeScreen(widget.userid)
                  ,),);
              }
              }
          }
        else{
          print("Userid and Password not found");
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
                    Image.network('https://googleflutter.com/sample_image.jpg',// width: 300,
                      height: 120,
                    ),
                    SizedBox(height: 5,),

                    Text(
                      widget.soc_name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .2,
                            fontSize: 15,
                        ),
                      ),
                    ),


                    SizedBox(height: 20,),
                    Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .2,
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 30),
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
                                    "User ID",
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

                                SizedBox(height: 30,),


                                Container(
                                  child: Text(
                                    "Password",
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
                                    controller: controllerPassword,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      //contentPadding: EdgeInsets.all(1),
                                      hintText: 'Enter your Password',
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
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  width: double.infinity,
                                  child:  TextButton(
                                    child: Text('LOGIN'),
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
        height: 49,
        color: Color.fromRGBO(80, 109, 138, 1),
      ),
    );
  }
}
