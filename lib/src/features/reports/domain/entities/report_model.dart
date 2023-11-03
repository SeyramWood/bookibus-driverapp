import 'dart:io';


class ReportModel {
  final String time;
  final String location;
  final String description;
  final int tripId;
  final int driverId;
  final List<File> images;
  final String? voiceNote;

  ReportModel({
    required this.time,
    required this.location,
    required this.description,
    required this.tripId,
    required this.driverId,
    required this.images,
    required this.voiceNote,
  });

  Map<String, dynamic> toJson() {
    
    return {
      'time': time,
      'location': location,
      'description': description,
      'tripId': tripId,
      'driverId': driverId,
      'images':  images,
      'voiceNote': voiceNote,
    };
  }
}
