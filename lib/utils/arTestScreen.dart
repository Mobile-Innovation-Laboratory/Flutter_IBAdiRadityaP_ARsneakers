import 'dart:io';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';

class ArTestScreen extends StatefulWidget {
  const ArTestScreen({super.key});

  @override
  State<ArTestScreen> createState() => _ArTestScreenState();
}

class _ArTestScreenState extends State<ArTestScreen> {
  ArCoreController? arCoreController;

  void _onArCoreViewCreated(ArCoreController _arcoreController) {
    arCoreController = _arcoreController;

    // Aktifkan event tap pada plane
    arCoreController?.onPlaneTap = _onPlaneTap;
  }

  void _onPlaneTap(List<ArCoreHitTestResult> hits) {
    if (hits.isNotEmpty) {
      final hit = hits.first;
      _addObject(hit.pose.translation);
    }
  }

  Future<String> _copyAssetToFile(String assetPath, String filename) async {
    final tempDir = await getApplicationDocumentsDirectory();
    final file = File('${tempDir.path}/$filename');

    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      final buffer = byteData.buffer;
      await file.writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }

    return file.path;
  }

  void _addObject(Vector3 position) async {
    try {
      final localPath =
          await _copyAssetToFile("assets/images/model.glb", "model.glb");

      final node = ArCoreReferenceNode(
        name: "glbModel",
        objectUrl: "file://$localPath",
        position: Vector3(position.x, position.y,
            position.z),
        scale: Vector3(0.5, 0.5, 0.5),
      );

      arCoreController
          ?.addArCoreNodeWithAnchor(node); 
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        arCoreController?.dispose(); 
        arCoreController = null;
        Get.offAllNamed(
            "/home"); 
        return false; 
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('AR Test Screen')),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enablePlaneRenderer: true,
          enableTapRecognizer: true,
        ),
      ),
    );
  }
}
