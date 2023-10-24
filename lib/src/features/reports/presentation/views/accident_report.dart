import 'package:bookihub/src/features/reports/presentation/views/emergency.dart';
import 'package:bookihub/src/features/reports/presentation/views/fleetMgt.dart';
import 'package:bookihub/src/shared/utils/exports.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Incident Report',
        style: Theme.of(context).textTheme.headlineMedium!),
        backgroundColor: bg,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReportCard(
                  title: "Emergency Service",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const EmergencyView();
                      },
                    ));
                  },
                ),
                ReportCard(
                  title: "Fleet Mgt",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const FleetMgtReport();
                      },
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  ReportCard({super.key, this.title, this.onTap});
  final String? title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * .21,
        width: MediaQuery.sizeOf(context).width * .39,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: white),
        child: Center(
            child: Text(
          title!,
          style:
              Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 16),
          maxLines: 2,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}