import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class BodyHeadPage extends StatefulWidget {
  @override
  _BodyHeadPageState createState() => _BodyHeadPageState();
}

class _BodyHeadPageState extends State<BodyHeadPage> {
  late ARKitController arkitController;
  ARKitNode? hand;
  var position;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Body Tracking')),
        body: ARKitSceneView(
          configuration: ARKitConfiguration.bodyTracking,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap=(nodes) => onNodeTapHandler(nodes);
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodePinch=(pinch) => _onPinchHandler(pinch);
  }
  void _onPinchHandler(List<ARKitNodePinchResult> pinch){
    final pinchBode=pinch.firstWhere((element) => element.nodeName==hand?.name);

    if(pinchBode!=null){
      final scale=vector.Vector3.all(pinchBode.scale);
      hand?.scale=scale;

    }
  }

  void onNodeTapHandler(List<String> nodeList){
    final name=nodeList.first;
    arkitController.remove(name);

    showDialog(context: context, builder: (BuildContext context)=>
    AlertDialog(content: Text('You removed $name'),),
    );

    // hand=ARKitReferenceNode(url: "models.scnassets/beanie_cap_DAE.dae",
    // scale: vector.Vector3.all(0.030),
    // position: position,
    // );
    // arkitController.add(hand!);

  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    final panNode = pan.firstWhere((e) => e.nodeName == hand?.name);
    if (panNode != null) {
      final old = hand?.eulerAngles;
      final newAngleY = panNode.translation.x * math.pi / 180;
      hand?.eulerAngles =
          vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
    }
  }
  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitBodyAnchor)) {
      return;
    }
    final transform =
        anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.head);
    hand = _createSphere(transform!);
    arkitController.add(hand!, parentNodeName: anchor.nodeName);
  }

  ARKitNode _createSphere(Matrix4 transform) {
    position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y+0.3,
      transform.getColumn(3).z,
    );
    return ARKitReferenceNode(
      url: 'models.scnassets/Brown_Hat.obj',
      scale: vector.Vector3.all(0.030),
      position: position,
      eulerAngles: vector.Vector3(0, 0,0)
    );
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitBodyAnchor && mounted) {
      final transform =
          anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.head)!;
      final position = vector.Vector3(
        transform.getColumn(3).x,
        transform.getColumn(3).y+0.3,
        transform.getColumn(3).z,
      );
      hand?.position = position;
      // hand?.eulerAngles=vector.Vector3(90, 180, 180);
    }
  }
}