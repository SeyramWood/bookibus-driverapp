import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController? cameraController;

 Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    // Use the first camera from the list
    final firstCamera = cameras.first;

    // Initialize the camera
    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    // Initialize the camera controller
    await cameraController!.initialize();
  }

  Future<void> takePicture() async {
    try {
      // Ensure the camera is initialized
      if (cameraController != null &&
          cameraController!.value.isInitialized) {
        // Capture the picture
        final XFile picture = await cameraController!.takePicture();

        // Handle the captured picture, e.g., save or display it
        // You can use the 'picture' variable to get the file path or perform other actions
        print("Picture taken: ${picture.path}");
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

   @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
   cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Example"),
      ),
      body: cameraController != null && cameraController!.value.isInitialized
          ? CameraPreview(cameraController!)
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takePicture();
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
