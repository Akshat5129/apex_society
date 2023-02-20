import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, dynamic> result = {};

  late Box box1;
  String SocId= "";

  void createBox() async{
    box1 = await Hive.openBox('logindata');
    setState(() {
      SocId=box1.get("socID");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }

  @override
  Future<void> getProjectData() async {

    print("this");

    var headers = {
      'Content-Type': 'application/json',
    };
    var request =
    http.Request('POST', Uri.parse('http://mobileapp.parjinindiainfotech.in/api/MobileMenu/MobileMenu'));

    request.body = json.encode({"SocCd": SocId});

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
          margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.menu)
              ],
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Board",
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
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select your option",
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      letterSpacing: .2,
                      fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
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
                                    //Icon(Icons.access_time_filled),
                                    Image.network(result["result"][index]['menuLink'],
                                      errorBuilder: (context, url, error) => new Icon(Icons.error),
                                      // loadingBuilder: (BuildContext context, Widget child,
                                      //     ImageChunkEvent? loadingProgress) {
                                      //   if (loadingProgress == null) return child;
                                      //   return Center(
                                      //     child: CircularProgressIndicator(
                                      //       value: loadingProgress.expectedTotalBytes != null
                                      //           ? loadingProgress.cumulativeBytesLoaded /
                                      //           loadingProgress.expectedTotalBytes!
                                      //           : null,
                                      //     ),
                                      //   );
                                      // },
                                    ),
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
      ),],),

      bottomSheet:  Container(
        height: 49,
        color: Color.fromRGBO(80, 109, 138, 1),
      ),
    );
  }
}
