import 'package:apex_society/firstlogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

late Box box1;

Future<void> main() async {
  await Hive.initFlutter();
  box1 = await Hive.openBox('logindata');
  runApp(const MyApp());
  print("boxx 11");
  //print(box1.get("isLogged"));
}

// Future<void> main() async{
//   runApp(c onst MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello box");
    Future.delayed(Duration(
        seconds: 3
    ), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      FirstLogin()
        ,),);
    },);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 250, 255, 1),
      body: Center(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.only(top: 120.0),
                child: Image.asset(
                  "assets/images/logo_sample.png", width: 180,
                ),
              ),
              SizedBox(height: 30,),
              Container(alignment: Alignment.center,
                child: Text(
                  "Apex Society",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Colors.black87,
                        letterSpacing: .2,
                        fontSize: 32,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ),),
              SizedBox(height: 10,),
              new Container(
                child: new Container(
                  margin: EdgeInsets.only(top: 80.0),
                  child: Image.asset(
                      "assets/images/splash_img.png"
                  ),
                ),
              ),
              Container(
                height: 59,
                color: Color.fromRGBO(80, 109, 138, 1),
              )
            ],
          )
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
