import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/exports.dart';

class DeliveredInfoCard extends StatelessWidget {
  const DeliveredInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ListTile(
          dense: true,
          leading: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
          title: Text('Location'),
        ),
        const ListTile(
          dense: true,
          leading: Icon(
            Icons.person,
            color: grey,
          ),
          title: Text('Name'),
        ),
        const ListTile(
          dense: true,
          leading: Icon(
            Icons.phone,
            color: blue,
          ),
          title: Text('contact'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Review'),
          ),
        )
      ]),
    );
  }
}
