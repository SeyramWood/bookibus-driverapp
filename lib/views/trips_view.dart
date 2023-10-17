import 'package:bookihub/shared/constant/components/trip_card.dart';
import 'package:bookihub/shared/constant/components/trip_tab.dart';
import 'package:bookihub/shared/utils/exports.dart';

class TripsView extends StatefulWidget {
  const TripsView({super.key});

  @override
  State<TripsView> createState() => _TripsViewState();
}

int isSelected = 0;

 TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();



class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: scaffold,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.07,
              ),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.045,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                         SizedBox(width: MediaQuery.of(context).size.width*.045,),
                      shrinkWrap: true,
                      itemCount: tabs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TripsTab(
                          title: tabs[index]['title'],
                          index: index,
                          isSelectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = index;
                            });
                          },
                        );
                      }),
                ),
                isSelected == 0
               ? SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      shrinkWrap: true,
                      itemCount: cards.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return TripCard(
                          location: cards[index]['location'],
                          lDescription: cards[index]['lDescription'],
                          destination: cards[index]['destination'],
                          dDescription: cards[index]['dDescription'],
                          // index: index,
                          // isSelectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = index;
                            });
                          },
                        );
                      }),
                )
                : Container()
            ],
          ),
        ),
      );
  }
}