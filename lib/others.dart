import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dress_ar/body.dart';
import 'package:dress_ar/bodyMain.dart';
import 'package:dress_ar/config.dart';
import 'package:dress_ar/imageDetect.dart';
import 'package:dress_ar/face.dart';
import 'package:dress_ar/faceMain.dart';
import 'package:dress_ar/faceNew.dart';
import 'package:dress_ar/test.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      
      Card(
        child: ListTile(
          title: Text("Test"),
          subtitle: Text("Check if AR is working on your phone"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TestPage()));
          },
          trailing: Icon(Icons.arrow_forward_sharp),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Check Config"),
          subtitle: Text("AR Detection methods supported your phone"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckSupportPage()));
          },
          trailing: Icon(Icons.arrow_forward_sharp),
        ),
      ),
      ]),);
  }
}