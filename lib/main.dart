import 'package:bookihub/src/config/theme/light_theme.dart';
import 'package:bookihub/src/features/authentication/presentation/view/login_view.dart';

import 'src/shared/utils/exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme.themeData(),
        home: const LoginView());
  }
}

