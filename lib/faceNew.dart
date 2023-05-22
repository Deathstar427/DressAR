import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class FaceMaskPage extends StatefulWidget {
  @override
  _FaceMaskPageState createState() => _FaceMaskPageState();
}

class _FaceMaskPageState extends State<FaceMaskPage> {
  late ARKitController arkitController;
  ARKitNode? node;

  ARKitNode? leftEye;
  ARKitNode? rightEye;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Face Detection')),
        body: Container(
          child: ARKitSceneView(
            enableTapRecognizer: true,
            configuration: ARKitConfiguration.faceTracking,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap=(nodes) => onNodeTapHandler(nodes);
    this.arkitController.onNodePan=(pans) => _onPanHandler(pans);
    this.arkitController.onNodeRotation=(rotation)=>_onRotationHandler(rotation);
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }
  void onNodeTapHandler(List<String> nodeList){
    final name=nodeList.first;
    arkitController.remove(name);

    showDialog(context: context, builder: (BuildContext context)=>
    AlertDialog(content: Text('You removed $name'),),
    );
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    final rotationNode = rotation.firstWhere(
      (e) => e.nodeName == node?.name,
    );
    if (rotationNode != null) {
      final rotation = node?.eulerAngles ??
          vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
      node?.eulerAngles = rotation;

      setState(() {
        
      });
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan){
    final panNode=pan.firstWhere((element) => element.nodeName==node?.name);

    if(panNode!=null){
      final old=node?.eulerAngles;
      final newAngleY=panNode.translation.x *math.pi/180;
      node?.eulerAngles=vector.Vector3(old?.x??0,newAngleY,old?.z??0);
    }
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitFaceAnchor)) {
      return;
    }
  

    final material = ARKitMaterial(fillMode: ARKitFillMode.lines);
    anchor.geometry.materials.value = [material];

    node = ARKitReferenceNode(url: "models.scnassets/mask.obj",
    scale: vector.Vector3.all(0.01),
    eulerAngles: vector.Vector3(0, 180,0),
     );
    arkitController.add(node!, parentNodeName: anchor.nodeName);

    leftEye = _createEye(anchor.leftEyeTransform);
    arkitController.add(leftEye!, parentNodeName: anchor.nodeName);
    rightEye = _createEye(anchor.rightEyeTransform);
    arkitController.add(rightEye!, parentNodeName: anchor.nodeName);
  }

  ARKitNode _createEye(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y,
      transform.getColumn(3).z,
    );
    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(Colors.yellow),
    );
    final sphere = ARKitBox(
        materials: [material], width: 0.03, height: 0.03, length: 0.03);

    return ARKitNode(geometry: sphere, position: position);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitFaceAnchor && mounted) {
      final faceAnchor = anchor;
      arkitController.updateFaceGeometry(node!, anchor.identifier);
      _updateEye(leftEye!, faceAnchor.leftEyeTransform,
          faceAnchor.blendShapes['eyeBlink_L'] ?? 0);
      _updateEye(rightEye!, faceAnchor.rightEyeTransform,
          faceAnchor.blendShapes['eyeBlink_R'] ?? 0);
    }
  }

  void _updateEye(ARKitNode node, Matrix4 transform, double blink) {
    final scale = vector.Vector3(1, 1 - blink, 1);
    node.scale = scale;
  }
}