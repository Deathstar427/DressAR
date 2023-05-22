import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class BodyShirtPage extends StatefulWidget {
  @override
  _BodyShirtPageState createState() => _BodyShirtPageState();
}

class _BodyShirtPageState extends State<BodyShirtPage> {
  late ARKitController arkitController;
  ARKitNode? hand;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Body Tracking Sample')),
        body: ARKitSceneView(
          enablePanRecognizer: true,
          enablePinchRecognizer: true,
          configuration: ARKitConfiguration.bodyTracking,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onNodePinch=(pinch) => _onPinchHandler(pinch);
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch){
    final pinchBode=pinch.firstWhere((element) => element.nodeName==hand?.name);

    if(pinchBode!=null){
      final scale=vector.Vector3.all(pinchBode.scale);
      hand?.scale=scale;

    }
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
        anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.root);
    hand = _createSphere(transform!);
    arkitController.add(hand!, parentNodeName: anchor.nodeName);
  }

  ARKitNode _createSphere(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y,
      transform.getColumn(3).z,
    );
    return ARKitReferenceNode(
      url: 'models.scnassets/T-shirt-male-obj.obj',
      scale: vector.Vector3.all(0.05),
      position: position,
      // eulerAngles: vector.Vector3(90, 180, 180)
    );
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitBodyAnchor && mounted) {
      final transform =
          anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.root)!;
      final position = vector.Vector3(
        transform.getColumn(3).x,
        transform.getColumn(3).y-0.045,
        transform.getColumn(3).z,
      );
      hand?.position = position;
      // hand?.eulerAngles=vector.Vector3(90, 180, 180);
    }
  }
}