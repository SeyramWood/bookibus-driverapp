import 'package:bookihub/main.dart';
import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/delivery/presentation/provider/delivery_controller.dart';
import 'package:bookihub/src/features/delivery/presentation/views/confirm_to_deliver.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/carousel.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/info_card.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/button_extension.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageDetailsView extends StatefulWidget {
  PackageDetailsView({super.key, required this.package, this.cameraController});
  final Delivery package;
  CameraController? cameraController;

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  final codeController = TextEditingController();

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    // Use the first camera from the list
    final firstCamera = cameras.first;

    // Initialize the camera
    widget.cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
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
          title: Text(
            'Package Details',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: hPadding)
                .copyWith(top: hPadding + 7),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImageCarousel(
                    images: widget.package.packageImages,
                  ),
                  vSpace,
                  vSpace,
                  vSpace,
                  locator<InfoCard>(),
                  vSpace,
                  vSpace,
                  vSpace,
                  InkWell(
                    onTap: () async {
                      takePicture();
                      setState(() {});
                    },
                    child: Material(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.cameraController != null &&
                                    widget.cameraController!.value.isInitialized
                                ? Text(
                                    "Recepient's ID",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "Take photo of ID",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .02,
                            ),
                            SizedBox(
                              height: 30,
                              width: 60,
                              child: widget.cameraController != null &&
                                      widget
                                          .cameraController!.value.isInitialized
                                  ? CameraPreview(widget.cameraController!)
                                  : ImageIcon(
                                      AssetImage(
                                        CustomeImages.camera,
                                      ),
                                      color: black,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  vSpace,
                  Material(
                    borderRadius: borderRadius,
                    child: TextFormField(
                        controller: codeController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintText: 'Enter package code',
                        )),
                  ),
                  vSpace,
                  vSpace,
                  vSpace,
                  CustomButton(
                    onPressed: () async {
                      await context
                          .read<DeliveryProvider>()
                          .verifyPackageCode(
                              '${widget.package.id}', codeController.text)
                          .then(
                        (value) {
                          value.fold(
                              (failure) => showCustomSnackBar(
                                  context, failure.message, orange),
                              (success) => confirmToDeliver(
                                    context,
                                    onPressed: () {},
                                  ));
                        },
                      );
                    },
                    child: const Text('Confirm Code'),
                  ).loading(context.watch<DeliveryProvider>().isLoading)
                ]),
          ),
        ));
  }
}
