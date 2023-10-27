import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';

class FleetMgtReport extends StatelessWidget {
  const FleetMgtReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Fleet Mgt Report",
            style: Theme.of(context).textTheme.headlineMedium!),
        backgroundColor: bg,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .06,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Incident Time",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  TextFormField(
                    cursorColor: grey,
                    decoration: InputDecoration(
                        hintText: "When it occurred",
                        filled: true,
                        fillColor: white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: grey,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: grey,
                            ),
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .04,
                  ),
                  Text(
                    "Description of incident",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .25,
                        child: TextFormField(
                          cursorColor: grey,
                          decoration: InputDecoration(
                              hintText: "What happened?",
                              filled: true,
                              fillColor: white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5))),
                          expands: true,
                          maxLines: null,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .04,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Material(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add images",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .02,
                            ),
                            ImageIcon(
                              AssetImage(
                                CustomeImages.camera,
                              ),
                              color: black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .08,
                  ),
                  CustomButton(
                    onPressed: () {},
                    title: 'Submit Report',
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
