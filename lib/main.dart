import 'package:dress_ar/body.dart';
import 'package:dress_ar/bodyMain.dart';
import 'package:dress_ar/config.dart';
import 'package:dress_ar/imageDetect.dart';
import 'package:dress_ar/face.dart';
import 'package:dress_ar/faceMain.dart';
import 'package:dress_ar/faceNew.dart';
import 'package:dress_ar/others.dart';
import 'package:dress_ar/test.dart';
import 'package:flutter/material.dart';

import 'package:dress_ar/others.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(226, 222, 169, 1.0),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(color:Color.fromRGBO(236, 166, 166,1.0) ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      defaultNextScreen: const MyHomePage(title: 'DressAR'),
      gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(209, 140, 224, 1.0),
              Color.fromRGBO(226, 222, 169, 1.0),
            ],
          ),
       childWidget: SizedBox(height: 200,
       child: Image.asset("assets/logo.png"),
       ),
       duration: const Duration(milliseconds: 1500),
        animationDuration: const Duration(milliseconds: 1000),

       
       );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(tabs: [
            Tab(text: "AR",),
            Tab(text:"Other",),
          ]),
          
        ),
        body:  const TabBarView(children: 
        [
          FirstPage(),
          SecondPage(),
        ]
        )
        ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      
    
      Card(
        child: ListTile(
          title: Text("Face Detection"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FaceMain()));
          },
          trailing: Icon(Icons.arrow_forward_sharp),
        ),
      ),
    
      Card(
        child: ListTile(
          title: Text("Image Detection"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageDetectionPageSec()));
          },
          trailing: Icon(Icons.arrow_forward_sharp),
        ),
      ),
    
      Card(
        child: ListTile(
          title: Text("Body Detection"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> BodyMain()));
          },
          trailing: Icon(Icons.arrow_forward_sharp),
        ),
      ),
    
    ]),);
  }
}


