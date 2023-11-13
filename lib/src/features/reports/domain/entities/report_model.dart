import 'dart:convert';
import 'dart:io';

import 'package:bookihub/src/shared/constant/model.dart';

import '../../../trip/domain/entities/trip_model.dart';

class ReportingModel {
  final String time;
  final String location;
  final String description;
  final int tripId;
  final int driverId;
  final List<File> images;
  final File? voiceNote;

  ReportingModel({
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
      'images': images,
      'voiceNote': voiceNote,
    };
  }
}

// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

class ReportModel {
  Data data;
  bool status;

  ReportModel({
    required this.data,
    required this.status,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );
}

class Data {
  int count;
  List<Report> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] ?? 0,
        data: List<Report>.from(
            json["data"]?.map((x) => Report.fromJson(x)) ?? []),
      );
}

class Report {
  int id;
  DateTime time;
  String location;
  String description;
  String? audio;
  List<VImage> images;
  Trip? trip;
  DateTime createdAt;
  DateTime updatedAt;

  Report({
    required this.id,
    required this.time,
    required this.location,
    required this.description,
    required this.audio,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        location: json["location"]??'',
        description: json["description"]??'',
        audio: json["audio"]??'',
        images:
            List<VImage>.from(json["images"].map((x) => VImage.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
