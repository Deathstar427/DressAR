import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _DressPageState();
}

class _DressPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dress try on')),
      body: ARKitSceneView(onARKitViewCreated: (controller) => arView(controller),),
    );
  }
}

void arView(ARKitController controller){
  final nodeAr = ARKitNode(geometry: 
  ARKitSphere(materials: 
  [
    ARKitMaterial(
      diffuse: ARKitMaterialProperty.image("assets/image.jpeg"),
      doubleSided: true,
      ),
  ],
  radius: 0.2
  ),
  position: Vector3(0,0,0),
  );
  controller.add(nodeAr);
}