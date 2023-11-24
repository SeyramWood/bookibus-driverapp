import 'package:bookihub/src/features/authentication/login_view.dart';
import 'package:bookihub/src/features/reports/presentation/dependency/report_dependencies.dart';
import 'package:bookihub/src/features/trip/presentation/dependency/trip_dependency.dart';
import 'package:bookihub/src/shared/utils/interceptor.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'src/features/delivery/presentation/dependency/delivery_dependencies.dart';
import 'src/shared/utils/exports.dart';

GetIt locator = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  interceptorLocator();
  injectTripDependencies();
  injectDeliveryDependencies();
  injectReportDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => tripProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => deliverProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => reportProvider,
        )
      ],
      child: DevicePreview(
enabled: false,

        builder: (BuildContext context) => MaterialApp(
          useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            theme: LightTheme.themeData(),
            home: const LoginView()),
      ),
    );
  }
}


// sk.eyJ1IjoiMDU0NDUxMTU4MSIsImEiOiJjbG9iczNqeXAweWh2MndxcWhsdWN4bjhqIn0.6iHDsqPV-J2QwxR-Uw9-Zg
