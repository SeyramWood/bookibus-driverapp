import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
CameraScreen({super.key, this.cameraController,});
CameraController? cameraController;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

 Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    // Use the first camera from the list
    final firstCamera = cameras.first;

    // Initialize the camera
    widget.cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // Initialize the camera controller
    await widget.cameraController!.initialize();
  }

  Future<void> takePicture() async {
    try {
      // Ensure the camera is initialized
      if (widget.cameraController != null &&
          widget.cameraController!.value.isInitialized) {
        // Capture the picture
        final XFile picture = await widget.cameraController!.takePicture();

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
    // takePicture();
  }

  @override
  void dispose() {
   widget.cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take photo"),
      ),
      body: 
      // SizedBox(
      //   height: MediaQuery.sizeOf(context).height,
      //   width: MediaQuery.sizeOf(context).width,
      //   child:
        FutureBuilder(
      future: initializeCamera(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(widget.cameraController!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        takePicture();
      },
      child: Icon(Icons.camera),
      ),
      // )
    );
  }
}
