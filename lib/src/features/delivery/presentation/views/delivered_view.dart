import 'package:bookihub/src/features/delivery/presentation/widgets/delivered_info_card.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:flutter/material.dart';


class DeliveredView extends StatelessWidget {
  const DeliveredView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (context, index) => vSpace,
      itemBuilder: (context, index) {
        return const DeliveredInfoCard();
      },
    );
  }
}
