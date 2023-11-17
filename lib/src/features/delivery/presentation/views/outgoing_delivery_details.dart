import 'dart:io';

import 'package:bookihub/main.dart';
import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/delivery/presentation/provider/delivery_controller.dart';

import 'package:bookihub/src/features/delivery/presentation/views/success_delivery.dart';
import 'package:bookihub/src/features/delivery/presentation/views/take_photo.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/carousel.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/info_card.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/button_extension.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class PackageDetailsView extends StatefulWidget {
  const PackageDetailsView({
    super.key,
    required this.package,
  });
  final Delivery package;

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  final codeController = TextEditingController();
  String? capturedImagePath; // Track the file path of the captured image

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
                      // Navigate to CameraScreen and wait for the result
                      final String? filePath = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(),
                        ),
                      );

                      // Handle the result (filePath) from CameraScreen
                      if (filePath != null) {
                        setState(() {
                          capturedImagePath = filePath;
                        });
                      }
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
                            capturedImagePath == null
                                ? Text(
                                    "Take photo of ID",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "Recepient's ID",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .02,
                            ),
                            SizedBox(
                              height: capturedImagePath == null ? 30 : 100,
                              width: capturedImagePath == null ? 60 : 130,
                              child: capturedImagePath == null
                                  ? ImageIcon(
                                      AssetImage(
                                        CustomeImages.camera,
                                      ),
                                      color: black,
                                    )
                                  : Image.file(
                                      File(capturedImagePath!), //
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  vSpace,
                  vSpace,
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
                      if (capturedImagePath == null) {
                        await context
                            .read<DeliveryProvider>()
                            .verifyPackageCode('${widget.package.id}',
                                codeController.text, File(capturedImagePath!))
                            .then(
                          (value) {
                            value.fold(
                                (failure) => showCustomSnackBar(
                                    context, failure.message, orange),
                                (success) => successDelivery(
                                      context,
                                    ));
                          },
                        );
                      }
                    },
                    child: const Text('Confirm Code'),
                  ).loading(context.watch<DeliveryProvider>().isLoading)
                ]),
          ),
        ));
  }
}
