import 'package:bookihub/main.dart';
import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/delivery/presentation/provider/delivery_controller.dart';
import 'package:bookihub/src/features/delivery/presentation/views/confirm_to_deliver.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/carousel.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/info_card.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageDetailsView extends StatefulWidget {
  const PackageDetailsView({super.key, required this.package});
  final Delivery package;

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  final codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
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
                  ElevatedButton(
                    onPressed: () async {
                      print(widget.package.packageCode);
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
                    child: const Text('Check Code'),
                  )
                ]),
          ),
        ));
  }
}
