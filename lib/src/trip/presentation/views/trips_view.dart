import 'package:bookihub/src/shared/utils/exports.dart';


class TripsView extends StatefulWidget {
  const TripsView({super.key});

  @override
  State<TripsView> createState() => _TripsViewState();
}

int isSelected = 0;
int selectedTab = 0;

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
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
                  separatorBuilder: (context, index) => SizedBox(
                        width: MediaQuery.sizeOf(context).width * .045,
                      ),
                  shrinkWrap: true,
                  itemCount: tabs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TripsTab(
                      title: tabs[index]['title'],
                      index: index,
                      isSelectedIndex: selectedTab,
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                    );
                  }),
            ),
            selectedTab == 0
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: MediaQuery.sizeOf(context).height * .02,
                            ),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TripDetails(),
                              ));
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
