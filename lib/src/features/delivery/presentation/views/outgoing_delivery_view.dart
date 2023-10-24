import 'package:bookihub/src/features/delivery/presentation/views/outgoing_delivery_details.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:flutter/material.dart';

import '../widgets/info_card.dart';

class OutGoingView extends StatelessWidget {
  const OutGoingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (context, index) => vSpace,
      itemBuilder: (context, index) {
        return InfoCard(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PackageDetailsView(),
          )),
        );
      },
    );
  }
}
