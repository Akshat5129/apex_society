import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  String socID;


  HomeScreen(this.socID);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, dynamic> result = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getProjectData();
  }

  @override
  Future<void> getProjectData() async {

    print("this");

    var headers = {
      'Content-Type': 'application/json',
    };
    var request =
    http.Request('POST', Uri.parse('http://mobileapp.parjinindiainfotech.in/api/MobileMenu/MobileMenu'));

    request.body = json.encode({"SocCd": widget.socID});

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
      print(result["result"][0]['menuName']);
      print(result["result"][0]["menuIcon"]);


      print("data GET SUccessfull");
    } else {
      print(response.reasonPhrase);
      print("failed");
    }
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    getProjectData();
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
        Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
                child: GridView.count(
                  childAspectRatio: (1 / 0.85),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: result["result"]==null?[]:
                  List.generate(
                    //box2.get('isLogged',defaultValue: false)?MyPhone(title: "phone"):Verify(),
                      result["result"].length,//this is the total number of cards
                          (index){
                        return Container(

                          child: Card(
                              color: Color.fromRGBO(255, 240, 212, 1),
                              child:Container(
                                padding: EdgeInsets.all(16),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.access_time_filled),
                                    SizedBox(height: 5,),
                                    Text(
                                      result["result"][index]['menuName'],
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
                        );
                      }
                  ),
                )
            ),
          ],
        ),
      ),],)
    );
  }
}
