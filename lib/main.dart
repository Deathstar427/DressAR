import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:dress_ar/config.dart';
import 'package:dress_ar/earth%20copy.dart';
import 'package:dress_ar/earth.dart';
import 'package:dress_ar/face.dart';
import 'package:dress_ar/test.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',

      home: MyHomePage(title: 'DressAR'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  Center(child: Column(children: [

        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TestPage()));
        }, child: Text("Test AR")),

        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckSupportPage()));
        }, child: Text("Check config")),

        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageDetectionPage()));
        }, child: Text("Earth")),

        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FaceDetectionPage()));
        }, child: Text("Face")),

        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageDetectionPageSec()));
        }, child: Text("try image")),

      ]),)
      );
  }
}


