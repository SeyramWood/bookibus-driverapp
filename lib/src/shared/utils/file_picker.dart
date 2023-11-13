 import 'dart:io';

import 'package:file_picker/file_picker.dart';



import 'package:camera/camera.dart';

Future<List<File>> captureImages() async {
  List<File> images = [];

  // Fetch the available cameras
  List<CameraDescription> cameras = await availableCameras();

  // Use the first available camera
  CameraController cameraController = CameraController(
    cameras[0],
    ResolutionPreset.medium,
  );

  // Initialize the camera
  await cameraController.initialize();

  // Open the camera for capturing images
  await cameraController.takePicture();

  // Dispose of the camera controller after capturing the image
  await cameraController.dispose();

  // Alternatively, you can use the image_picker package to pick an image from the gallery
  // final imagePicker = ImagePicker();
  // final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  // if (pickedFile != null) {
  //   images.add(File(pickedFile.path));
  // }

  return images;
}


Future<List<File>> selectFiles() async {
  List<File> files =[];
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
       files = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      return files;
    }
    return [];
  }