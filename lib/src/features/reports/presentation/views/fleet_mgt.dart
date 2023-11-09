import 'dart:io';

import 'package:bookihub/src/features/reports/domain/entities/report_model.dart';
import 'package:bookihub/src/features/reports/presentation/provider/report_controller.dart';
import 'package:bookihub/src/shared/utils/button_extension.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../../../main.dart';
import '../../../../shared/utils/file_picker.dart';
import '../../../../shared/utils/show.snacbar.dart';
import '../../../trip/domain/entities/trip_model.dart';

class FleetMgtReport extends StatefulWidget {
  const FleetMgtReport({super.key});

  @override
  State<FleetMgtReport> createState() => _FleetMgtReportState();
}

class _FleetMgtReportState extends State<FleetMgtReport> {
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  var images = <File>[];
  var trip = locator<Trip>();

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final selectedTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      timeController.text =
          '${selectedTime.toIso8601String().split('.').first}Z';
    }
  }

  String initialValue = 'Mechanical Issue';

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
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    controller: timeController,
                    cursorColor: grey,
                    readOnly: true,
                    onTap: _selectTime,
                    decoration: InputDecoration(
                        isDense: true,
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
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  Container(
                    width: 325,
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(width: 0.50, color: grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      underline: const SizedBox(), // Removes the underline
                      isExpanded: true, // Ensures the dropdown fills the width
                      value:
                          initialValue, // Replace selectedValue with your current selection
                      onChanged: (String? newValue) {
                        setState(() {
                          initialValue = newValue ?? initialValue;
                        });
                      },
                      items: <String>['Mechanical Issue', 'Other Issue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      height: 0.84),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  Text(
                    "Description of incident",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .01,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .13,
                        child: TextFormField(
                          controller: descriptionController,
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
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  const Material(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(children: [
                        Text('Record voice'),
                        Spacer(),
                        Icon(Icons.mic_none_sharp)
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  InkWell(
                    onTap: () async {
                      images = await selectFiles();
                      setState(() {});
                    },
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
                    height: MediaQuery.sizeOf(context).height * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomButton(
                      onPressed: () async {
                        var report = ReportingModel(
                          time: timeController.text,
                          tripId: trip.id,
                          images: images,
                          driverId: trip.driver.id,
                          location: 'Pedu',
                          description: descriptionController.text,
                          voiceNote: '',
                        );
                        await context
                            .read<ReportProvider>()
                            .makeReport('${trip.company.id}', report)
                            .then(
                          (value) {
                            value.fold(
                                (failure) => showCustomSnackBar(
                                    context, failure.message, orange),
                                (success) => showCustomSnackBar(
                                    context, success, green));
                          },
                        );
                      },
                      child: const Text('Submit Report'),
                    ).loading(context.watch<ReportProvider>().isLoading),
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
