import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ImageDetectionPageSec extends StatefulWidget {
  @override
  _ImageDetectionPageSecState createState() => _ImageDetectionPageSecState();
}

class _ImageDetectionPageSecState extends State<ImageDetectionPageSec> {
  late ARKitController arkitController;
  Timer? timer;
  bool anchorWasFound = false;

  ARKitNode? node1;

  @override
  void dispose() {
    timer?.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Image Detection Sample')),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ARKitSceneView(
                detectionImagesGroupName: 'AR Resources',
                onARKitViewCreated: onARKitViewCreated,
              ),
              anchorWasFound
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Point the camera at the image',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      setState(() => anchorWasFound = true);

      // final imagePosition = anchor.transform.getColumn(3);
      final imagePosition =anchor.transform.getTranslation();

      node1 = ARKitReferenceNode( url: 'models.scnassets/watch2.dae',
       scale: vector.Vector3.all(.01), 
      position: vector.Vector3(imagePosition.x, imagePosition.y-1.0, imagePosition.z));

      arkitController.add(node1!, parentNodeName: anchor.nodeName);

    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitBodyAnchor && mounted) {
      final transform =
          anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.root)!;
      final position = vector.Vector3(
        transform.getColumn(3).x,
        transform.getColumn(3).y,
        transform.getColumn(3).z,
      );
      node1?.position = position;
    }
  }
}