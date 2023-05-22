import 'package:dress_ar/body.dart';
import 'package:dress_ar/bodyHand.dart';
import 'package:dress_ar/bodyHead.dart';
import 'package:dress_ar/bodyShirt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Try On"),
      ),
      body: Center(
        child: Column(children: [
          Card(
            child: ListTile(
              title: Text("jeans"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyTrackingPage()));
              },
              trailing: Icon(Icons.arrow_forward_sharp),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Head Gear"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyHeadPage()));
              },
              trailing: Icon(Icons.arrow_forward_sharp),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Shirt"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyShirtPage()));
              },
              trailing: Icon(Icons.arrow_forward_sharp),
            ),
          ),

          // Card(
          //   child: ListTile(
          //     title: Text("HandBag"),
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyHandPage()));
          //     },
          //     trailing: Icon(Icons.arrow_forward_sharp),
          //   ),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset("assets/scan.json"),
            ),
          ),
        ]),
      ),
    );
  }
}