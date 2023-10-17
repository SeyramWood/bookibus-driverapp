// import 'package:bookihub/shared/utils/exports.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(milliseconds: 4000), () {
//       Navigator.pop(context);
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return const TripsView();
//       },));
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height*1,
//           width: MediaQuery.sizeOf(context).width * 1,
//           decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage(CustomeImages.logo))),
//         ),
//       ),
//     );
//   }
// }
