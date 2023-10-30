import 'package:bookihub/src/config/theme/light_theme.dart';
import 'package:bookihub/src/features/authentication/login_view.dart';
import 'package:bookihub/src/features/trip/presentation/dependency/trip_dependency.dart';
import 'package:bookihub/src/shared/utils/interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'src/shared/utils/exports.dart';
GetIt locator = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  interceptorLocator();
  injectTripDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tripProvider,)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: LightTheme.themeData(),
          home: const LoginView()),
    );
  } 
}


// sk.eyJ1IjoiMDU0NDUxMTU4MSIsImEiOiJjbG9iczNqeXAweWh2MndxcWhsdWN4bjhqIn0.6iHDsqPV-J2QwxR-Uw9-Zg
