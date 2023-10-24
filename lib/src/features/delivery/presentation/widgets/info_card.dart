import 'package:bookihub/src/shared/utils/exports.dart';

import '../../../../shared/constant/dimensions.dart';

class InfoCard extends StatelessWidget {
  final void Function()? onTap;
  const InfoCard({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Material(
        borderRadius: borderRadius,
        child: const Column(children: [
          ListTile(
            dense: true,
            leading: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            title: Text('Location'),
          ),
          ListTile(
            dense: true,
            leading: Icon(
              Icons.person,
              color: grey,
            ),
            title: Text('Name'),
          ),
          ListTile(
            dense: true,
            leading: Icon(
              Icons.phone,
              color: blue,
            ),
            title: Text('contact'),
          ),
        ]),
      ),
    );
  }
}
