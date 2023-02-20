import 'dart:convert';

import 'package:apex_society/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SchemeAcc extends StatefulWidget {
  const SchemeAcc({Key? key}) : super(key: key);

  @override
  State<SchemeAcc> createState() => _SchemeAccState();
}

class _SchemeAccState extends State<SchemeAcc> {


  Map<String, dynamic> result = {};

  String path = "";

  late Box box1;
  String SocId= "";

  void createBox() async{
    box1 = await Hive.openBox('logindata');
    setState(() {
      SocId=box1.get("socID");
    });
    getSchemeData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();

  }


  @override
  Future<void> getSchemeData() async {

    print("this");

    var headers = {
      'Content-Type': 'application/json',
    };
    var request =
    http.Request('POST', Uri.parse('http://mobileapp.parjinindiainfotech.in/api/Scheme/GetMemberScheme'));

    request.body = json.encode({"SocietyCode": SocId,"SocietyYear" :"2022-2023","MemberId":box1.get("userName")});

    request.headers.addAll(headers);
    print("req" + request.toString());
    print("body" + request.body);
    print("headers" + request.headers.toString());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var res;
      res = jsonDecode(await response.stream.bytesToString()) as Map<String, dynamic>;
      setState(() {
        result = res;
      });

      print(result);
      print(result["result"][0]['schemeName']);
      print(result["result"][1]["schemeName"]);


      print("data GET SUccessfull");
    } else {
      print(response.reasonPhrase);
      print("failed");
    }
    print(response.statusCode);
  }


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

                Container(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: (1 / 0.75),
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: result["result"]==null?[]:
                      List.generate(
                        //box2.get('isLogged',defaultValue: false)?MyPhone(title: "phone"):Verify(),
                          result["result"].length,//this is the total number of cards
                              (index){
                            print(index.toString());
                            print(result["result"][index]['schemeName'] == "MEMBER");
                            if(result["result"][index]['schemeName'] == "MEMBER"){
                              path='assets/images/member.png';
                              print("PATH1:"+path);
                            }if(result["result"][index]['schemeName'] == "LOAN"){
                              path="assets/images/loan.png";
                            }if(result["result"][index]['schemeName'] == "C.S" || result["result"][index]['schemeName'] == "F.D."){
                              path="assets/images/CS.png";
                            }if(result["result"][index]['schemeName'] == "SAVING"){
                              path="assets/images/saving.png";
                            }

                            print("PATH::"+path);

                            return Container(

                                child: GestureDetector(child: Card(
                                    color: Color.fromRGBO(241, 250, 255, 1.0),
                                    child:Container(
                                      padding: EdgeInsets.all(16),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(path,height: 50,),
                                          SizedBox(height: 5,),
                                          Text(
                                            result["result"][index]['schemeName'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.blueGrey,
                                                  letterSpacing: .2,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  //Text(result["response"][index]["Name"]),
                                ),
                                  onTap: (){

                                  },
                                )
                            );
                          }
                      ),
                    )
                ),

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
