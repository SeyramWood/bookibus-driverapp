import 'package:bookihub/src/features/delivery/presentation/views/success_delivery.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/carousel.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/info_card.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:flutter/material.dart';

class PackageDetailsView extends StatelessWidget {
  const PackageDetailsView({super.key});

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: hPadding)
              .copyWith(top: hPadding + 7),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const ImageCarousel(
              images: [
                "https://media.istockphoto.com/id/1224913822/photo/paper-bag-with-food-gray-background.jpg?s=2048x2048&w=is&k=20&c=WPhcxuExZXJQoem0ad2nR1diy2edFeAFogKFEjGFfc0=",
                "https://media.istockphoto.com/id/1224913822/photo/paper-bag-with-food-gray-background.jpg?s=2048x2048&w=is&k=20&c=WPhcxuExZXJQoem0ad2nR1diy2edFeAFogKFEjGFfc0=",
                "https://media.istockphoto.com/id/1224913822/photo/paper-bag-with-food-gray-background.jpg?s=2048x2048&w=is&k=20&c=WPhcxuExZXJQoem0ad2nR1diy2edFeAFogKFEjGFfc0="
              ],
            ),
            vSpace,
            vSpace,
            vSpace,
            const InfoCard(),
            vSpace,
            vSpace,
            vSpace,
            Material(
              borderRadius: borderRadius,
              child: const TextField(
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: InputBorder.none,
                hintText: 'Enter package code',
              )),
            ),
            vSpace,
            vSpace,
            vSpace,
            ElevatedButton(
              onPressed: () => successDelivery(context),
              child: const Text('Check Code'),
            )
          ]),
        ));
  }
}
