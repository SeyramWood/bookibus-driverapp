// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraScreen extends StatefulWidget {
//   CameraScreen({Key? key}) : super(key: key);
//   CameraController? cameraController;

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = initializeCamera();
//   }

//   Future<void> initializeCamera() async {
//     try {
//       final cameras = await availableCameras();

//       if (cameras.isEmpty) {
//         print("No camera available");
//         return;
//       }

//       final firstCamera = cameras.first;

//       widget.cameraController = CameraController(
//         firstCamera,
//         ResolutionPreset.high,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );

//       await widget.cameraController!.initialize();
//     } catch (e) {
//       print("Error initializing camera: $e");
//     }
//   }

//   Future<void> takePicture() async {
//     try {
//       // Ensure the camera is initialized
//       if (widget.cameraController != null &&
//           widget.cameraController!.value.isInitialized) {
//         // Capture the picture
//         final XFile picture =
//             await widget.cameraController!.takePicture();

//         // Handle the captured picture, e.g., save or display it
//         // You can use the 'picture' variable to get the file path or perform other actions
//         print("Picture taken: ${picture.path}");
        
//       }
//     } catch (e) {
//       print("Error taking picture: $e");
//     }
//   }

//   @override
//   void dispose() {
//     widget.cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Take photo"),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return CameraPreview(widget.cameraController!);
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           takePicture();
//           Navigator.pop(context);
//         },
//         child: const Icon(Icons.camera),
//       ),
//     );
//   }
// }


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);
  CameraController? cameraController;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        print("No camera available");
        return;
      }

      final firstCamera = cameras.first;

      widget.cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await widget.cameraController!.initialize();
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> takePicture() async {
    try {
      // Ensure the camera is initialized
      if (widget.cameraController != null &&
          widget.cameraController!.value.isInitialized) {
        // Capture the picture
        final XFile picture =
            await widget.cameraController!.takePicture();

        // Handle the captured picture, e.g., save or display it
        // You can use the 'picture' variable to get the file path or perform other actions
        print("Picture taken: ${picture.path}");

        // Send the captured photo back to the previous screen
        Navigator.pop(context, picture.path);
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
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
        title: const Text("Take photo"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(widget.cameraController!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takePicture();
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}

