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


// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraScreen extends StatefulWidget {
//   CameraScreen({Key? key}) : super(key: key);

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController1;
//   late CameraController _cameraController2;
//   late Future<void> _initializeControllersFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllersFuture = initializeCameras();
//   }

//   Future<void> initializeCameras() async {
//     try {
//       final cameras = await availableCameras();

//       if (cameras.length < 2) {
//         print("Insufficient cameras available");
//         return;
//       }

//       _cameraController1 = CameraController(
//         cameras[0],
//         ResolutionPreset.high,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );
//       await _cameraController1.initialize();

//       _cameraController2 = CameraController(
//         cameras[1],
//         ResolutionPreset.high,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );
//       await _cameraController2.initialize();
//     } catch (e) {
//       print("Error initializing cameras: $e");
//     }
//   }

//   Future<void> takePicture(int cameraIndex) async {
//     try {
//       CameraController cameraController;
//       if (cameraIndex == 1) {
//         cameraController = _cameraController1;
//       } else {
//         cameraController = _cameraController2;
//       }

//       if (cameraController.value.isInitialized) {
//         final XFile picture = await cameraController.takePicture();
//         print("Picture taken from camera $cameraIndex: ${picture.path}");
//         // Handle the captured picture as needed
//         // For example, save or display it
//       }
//     } catch (e) {
//       print("Error taking picture: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController1.dispose();
//     _cameraController2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dual Camera"),
//       ),
//       body: FutureBuilder(
//         future: _initializeControllersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Row(
//               children: [
//                 Expanded(
//                   child: _cameraPreview(_cameraController1),
//                 ),
//                 Expanded(
//                   child: _cameraPreview(_cameraController2),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               takePicture(1); // Take picture from camera 1
//             },
//             child: const Icon(Icons.camera),
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               takePicture(2); // Take picture from camera 2
//             },
//             child: const Icon(Icons.camera),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _cameraPreview(CameraController controller) {
//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: CameraPreview(controller),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CameraScreen(),
//   ));
// }

// import 'dart:io';

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
//   late List<String> capturedImages; // New list to store captured images

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllerFuture = initializeCamera();
//     capturedImages = []; // Initialize the list
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
//         final XFile picture = await widget.cameraController!.takePicture();

//         // Handle the captured picture, e.g., save or display it
//         // You can use the 'picture' variable to get the file path or perform other actions
//         print("Picture taken: ${picture.path}");

//         // Add the captured photo to the list
//         capturedImages.add(picture.path);

//         // Update the UI to show the new list of images
//         setState(() {});

//         // Continue using the captured images list as needed

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
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: FutureBuilder(
//                 future: _initializeControllerFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return CameraPreview(widget.cameraController!);
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 },
//               ),
//             ),
//           ),
//           // Display the captured images in a ListView
//           if (capturedImages.isNotEmpty)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: capturedImages.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Image.file(File(capturedImages[index])),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           takePicture();
//         },
//         child: const Icon(Icons.camera),
//       ),
//     );
//   }
// }
