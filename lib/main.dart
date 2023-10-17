import 'package:bookihub/config/theme/light_theme.dart';
import 'package:bookihub/src/trip/presentation/views/map_view.dart';
import 'package:bookihub/src/trip/presentation/views/trip_detail_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: LightTheme.themeData(),
      home: const TripDetails(),
    );
  }
}
