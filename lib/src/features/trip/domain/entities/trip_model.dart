// To parse this JSON data, do
//
//     final tripModel = tripModelFromJson(jsonString);

import 'dart:convert';

import 'package:bookihub/src/shared/constant/model.dart';

TripModel tripModelFromJson(String str) => TripModel.fromJson(json.decode(str));

String tripModelToJson(TripModel data) => json.encode(data.toJson());

class TripModel {
  Data? data;
  bool status;

  TripModel({
    required this.data,
    required this.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  int count;
  List<Trip> trip;

  Data({
    required this.count,
    required this.trip,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] ?? 0,
        trip: List<Trip>.from(json["data"]?.map((x) => Trip.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(trip.map((x) => x.toJson())),
      };
}

class Trip {
  dynamic id;
  DateTime departureDate;
  DateTime arrivalDate;
  DateTime? returnDate;
  String type;
  InspectionStatus inspectionStatus;
  String status;
  bool scheduled;
  dynamic seatLeft;
  List<BoardingPoint> boardingPoint;
  Vehicle vehicle;
  Route route;
  Driver driver;
  Company company;
  DateTime createdAt;
  DateTime updatedAt;

  Trip({
    required this.id,
    required this.departureDate,
    required this.arrivalDate,
    this.returnDate,
    required this.type,
    required this.inspectionStatus,
    required this.status,
    required this.scheduled,
    required this.seatLeft,
    required this.boardingPoint,
    required this.vehicle,
    required this.route,
    required this.driver,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        departureDate: DateTime.parse(json["departureDate"]),
        arrivalDate: DateTime.parse(json["arrivalDate"]),
        returnDate:
            DateTime.parse(json["returnDate"] ?? DateTime.now().toString()),
        type: json["type"],
        inspectionStatus: InspectionStatus.fromJson(json["inspectionStatus"]),
        status: json["status"],
        scheduled: json["scheduled"],
        seatLeft: json["seatLeft"],
        boardingPoint: List<BoardingPoint>.from(
            json["boardingPoint"].map((x) => BoardingPoint.fromJson(x))),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        route: Route.fromJson(json["route"]),
        driver: Driver.fromJson(json["driver"]),
        company: Company.fromJson(json["company"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departureDate": departureDate.toIso8601String(),
        "arrivalDate": arrivalDate.toIso8601String(),
        "returnDate": returnDate?.toIso8601String(),
        "type": type,
        "inspectionStatus": inspectionStatus.toJson(),
        "status": status,
        "scheduled": scheduled,
        "seatLeft": seatLeft,
        "boardingPoint":
            List<dynamic>.from(boardingPoint.map((x) => x.toJson())),
        "vehicle": vehicle.toJson(),
        "route": route.toJson(),
        "driver": driver.toJson(),
        "company": company.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
