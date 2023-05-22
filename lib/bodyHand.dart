import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BodyHandPage extends StatefulWidget {
  @override
  _BodyHandPageState createState() => _BodyHandPageState();
}

class _BodyHandPageState extends State<BodyHandPage> {
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
          configuration: ARKitConfiguration.bodyTracking,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitBodyAnchor)) {
      return;
    }
    final transform =
        anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.leftHand);
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
      url: 'models.scnassets/.obj',
      scale: vector.Vector3.all(0.1),
      position: position,
      // eulerAngles: vector.Vector3(90, 180, 180)
    );
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitBodyAnchor && mounted) {
      final transform =
          anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.leftHand)!;
      final position = vector.Vector3(
        transform.getColumn(3).x,
        transform.getColumn(3).y,
        transform.getColumn(3).z,
      );
      hand?.position = position;
      // hand?.eulerAngles=vector.Vector3(90, 180, 180);
    }
  }
}