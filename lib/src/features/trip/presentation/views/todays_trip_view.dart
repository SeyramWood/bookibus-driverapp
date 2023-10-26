import 'package:bookihub/src/shared/constant/dimensions.dart';

import '../../../../shared/utils/exports.dart';

class TodayTripsView extends StatelessWidget {
  const TodayTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              height: MediaQuery.sizeOf(context).height * .02,
            ),
        shrinkWrap: true,
        itemCount: cards.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: cards[index] == cards.last ? vPadding : 0.0),
            child: TripCard(
              location: cards[index]['location'],
              lDescription: cards[index]['lDescription'],
              destination: cards[index]['destination'],
              dDescription: cards[index]['dDescription'],
              // index: index,
              // isSelectedIndex: isSelected,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TripDetails(),
                ));
              },
            ),
          );
        });
  }
}
