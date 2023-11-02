import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/delivery/presentation/provider/delivery_controller.dart';
import 'package:bookihub/src/features/delivery/presentation/widgets/delivered_info_card.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveredView extends StatefulWidget {
  const DeliveredView({super.key});

  @override
  State<DeliveredView> createState() => _DeliveredViewState();
}

class _DeliveredViewState extends State<DeliveredView> {
  Future<List<Delivery>>? delivery;
  fetchDeliveries() async {
    final result = await context
        .read<DeliveryProvider>()
        .fetchDelivery('12884901890', 'delivered');
    result
        .fold((failure) => showCustomSnackBar(context, failure.message, orange),
            (success) {
      setState(() {
        delivery = Future.value(success);
      });
    });
  }

  @override
  void initState() {
    fetchDeliveries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Delivery>>(
        future: delivery,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var package = snapshot.data!;

            return ListView.separated(
              itemCount: package.length,
              separatorBuilder: (context, index) => vSpace,
              itemBuilder: (context, index) {
                return const DeliveredInfoCard();
              },
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Deliver a package to see it here.'));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
