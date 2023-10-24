import 'package:bookihub/src/shared/utils/exports.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Emergency Service",
        style: Theme.of(context).textTheme.headlineMedium!),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .06,
            ),
            EmergencyCard(
              service: "Police Service",
              onTap: () {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            EmergencyCard(
              service: "Ambulance Service",
              onTap: () {},
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            EmergencyCard(
              service: "Fire Service",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  EmergencyCard({super.key, this.service, this.onTap});
  final String? service;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: grey),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                service!,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              ImageIcon(
                AssetImage(
                  CustomeImages.call,
                ),
                color: blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
