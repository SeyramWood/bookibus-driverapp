import 'package:bookihub/shared/constant/colors.dart';
import 'package:flutter/material.dart';

class TripInspectRow extends StatelessWidget {
  const TripInspectRow({
    super.key,
    required this.onChanged,
    required this.value,
    required this.label,
  });
  final bool value;
  final void Function(bool)? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          onChanged: onChanged,
          activeColor: blue,
          inactiveTrackColor: grey,
          value: value,
        )
      ],
    );
  }
}
