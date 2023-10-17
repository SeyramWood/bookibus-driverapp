import 'package:bookihub/shared/utils/exports.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: LightTheme.themeData(),
      home:const MainPage()
    );
  }
}
