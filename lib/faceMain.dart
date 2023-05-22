import 'package:dress_ar/body.dart';
import 'package:dress_ar/bodyHand.dart';
import 'package:dress_ar/bodyHead.dart';
import 'package:dress_ar/bodyShirt.dart';
import 'package:dress_ar/face.dart';
import 'package:dress_ar/faceNew.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class FaceMain extends StatefulWidget {
  const FaceMain({super.key});

  @override
  State<FaceMain> createState() => _FaceMainState();
}

class _FaceMainState extends State<FaceMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Try On"),
      ),
      body: Center(
        child: Column(children: [
          Card(
            child: ListTile(
              title: Text("Face Struct"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FaceDetectionPage()));
              },
              trailing: Icon(Icons.arrow_forward_sharp),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Face Mask"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FaceMaskPage()));
              },
              trailing: Icon(Icons.arrow_forward_sharp),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset("assets/face.json"),
            ),
          ),
        ]),
      ),
    );
  }
}