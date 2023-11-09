import 'package:bookihub/src/features/reports/domain/entities/report_model.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/utils/divider.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key, required this.report});
  final Report report;

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    final report = widget.report;

    return Material(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Incident ID'),
              const Spacer(),
              Text('${report.id}'),
            ],
          ),
          divider,
          Row(
            children: [
              const Text('Incident Type'),
              const Spacer(),
              SizedBox(
                height: 30,
                width: MediaQuery.sizeOf(context).width / 4,
                child: CustomButton(
                  onPressed: () {},
                  bgColor: orange,
                  child: const Text('type'),
                ),
              )
            ],
          ),
          divider,
          Row(
            children: [
              const Text('Incident Status'),
              const Spacer(),
              SizedBox(
                height: 30,
                width: MediaQuery.sizeOf(context).width / 4,
                child: CustomButton(
                  onPressed: () {},
                  bgColor: orange,
                  child: const Text('status'),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}