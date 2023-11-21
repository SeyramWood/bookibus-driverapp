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
  String? frontCapturedImagePath; // Track the file path of the captured image
  String? backCapturedImagePath;
  final idImages = <File>[];

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
                  locator<InfoCard>(),
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
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: const Text('Capture IDs (Optional)'),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
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
                                    frontCapturedImagePath = filePath;
                                    idImages.add(File(filePath));
                                  });
                                }
                              },
                              child: Material(
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: frontCapturedImagePath == null
                                            ? 30
                                            : 100,
                                        width: frontCapturedImagePath == null
                                            ? 60
                                            : 130,
                                        child: frontCapturedImagePath == null
                                            ? ImageIcon(
                                                AssetImage(
                                                  CustomeImages.camera,
                                                ),
                                                color: black,
                                              )
                                            : Image.file(
                                                File(
                                                    frontCapturedImagePath!), //
                                                height: 100.0,
                                                width: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .02,
                                      ),
                                      Text(
                                        "Recepient's ID (Front)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .01,
                          ),
                          Expanded(
                            child: InkWell(
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
                                    backCapturedImagePath = filePath;
                                    idImages.add(File(filePath));
                                  });
                                }
                              },
                              child: Material(
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: backCapturedImagePath == null
                                            ? 30
                                            : 100,
                                        width: backCapturedImagePath == null
                                            ? 60
                                            : 130,
                                        child: backCapturedImagePath == null
                                            ? ImageIcon(
                                                AssetImage(
                                                  CustomeImages.camera,
                                                ),
                                                color: black,
                                              )
                                            : Image.file(
                                                File(backCapturedImagePath!), //
                                                height: 100.0,
                                                width: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .02,
                                      ),
                                      Text(
                                        "Recepient's ID (Back)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  vSpace,
                  vSpace,
                  CustomButton(
                    onPressed: () async {
                      if (codeController.text.isEmpty) {
                        await context
                            .read<DeliveryProvider>()
                            .verifyPackageCode('${widget.package.id}',
                                codeController.text, idImages)
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
                      } else {
                        showCustomSnackBar(
                            context, 'Enter recepient\'s code', orange);
                      }
                    },
                    child: const Text('Confirm Code'),
                  ).loading(context.watch<DeliveryProvider>().isLoading),
                  vSpace
                ]),
          ),
        ));
  }
}
