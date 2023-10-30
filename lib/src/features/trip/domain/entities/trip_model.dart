// To parse this JSON data, do
//
//     final tripModel = tripModelFromJson(jsonString);

import 'dart:convert';

TripModel tripModelFromJson(String str) => TripModel.fromJson(json.decode(str));

String tripModelToJson(TripModel data) => json.encode(data.toJson());

class TripModel {
  Data data;
  bool status;

  TripModel({
    required this.data,
    required this.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
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
        count: json["count"],
        trip: List<Trip>.from(json["data"].map((x) => Trip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(trip.map((x) => x.toJson())),
      };
}

class Trip {
  int id;
  DateTime departureDate;
  DateTime arrivalDate;
  DateTime? returnDate;
  String type;
  InspectionStatus inspectionStatus;
  String status;
  bool scheduled;
  int seatLeft;
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

class BoardingPoint {
  String id;
  String location;

  BoardingPoint({
    required this.id,
    required this.location,
  });

  factory BoardingPoint.fromJson(Map<String, dynamic> json) => BoardingPoint(
        id: json["id"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
      };
}

class Company {
  int id;
  String name;
  String phone;
  String email;

  Company({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
      };
}

class Driver {
  int id;
  String lastName;
  String otherName;
  String phone;
  String otherPhone;

  Driver({
    required this.id,
    required this.lastName,
    required this.otherName,
    required this.phone,
    required this.otherPhone,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        lastName: json["lastName"],
        otherName: json["otherName"],
        phone: json["phone"],
        otherPhone: json["otherPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lastName": lastName,
        "otherName": otherName,
        "phone": phone,
        "otherPhone": otherPhone,
      };
}

class InspectionStatus {
  bool exterior;
  bool interior;
  bool engineCompartment;
  bool brakeAndSteering;
  bool emergencyEquipment;
  bool fuelAndFluid;

  InspectionStatus({
    required this.exterior,
    required this.interior,
    required this.engineCompartment,
    required this.brakeAndSteering,
    required this.emergencyEquipment,
    required this.fuelAndFluid,
  });

  factory InspectionStatus.fromJson(Map<String, dynamic> json) =>
      InspectionStatus(
        exterior: json["exterior"],
        interior: json["interior"],
        engineCompartment: json["engineCompartment"],
        brakeAndSteering: json["brakeAndSteering"],
        emergencyEquipment: json["emergencyEquipment"],
        fuelAndFluid: json["fuelAndFluid"],
      );

  Map<String, dynamic> toJson() => {
        "exterior": exterior,
        "interior": interior,
        "engineCompartment": engineCompartment,
        "brakeAndSteering": brakeAndSteering,
        "emergencyEquipment": emergencyEquipment,
        "fuelAndFluid": fuelAndFluid,
      };
}

class Route {
  int id;
  String from;
  String to;
  double fromLatitude;
  double fromLongitude;
  double toLatitude;
  double toLongitude;
  int rate;
  List<Stop> stops;

  Route({
    required this.id,
    required this.from,
    required this.to,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
    required this.rate,
    required this.stops,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        fromLatitude: json["fromLatitude"]?.toDouble(),
        fromLongitude: json["fromLongitude"]?.toDouble(),
        toLatitude: json["toLatitude"]?.toDouble(),
        toLongitude: json["toLongitude"]?.toDouble(),
        rate: json["rate"],
        stops: List<Stop>.from(json["stops"].map((x) => Stop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "fromLatitude": fromLatitude,
        "fromLongitude": fromLongitude,
        "toLatitude": toLatitude,
        "toLongitude": toLongitude,
        "rate": rate,
        "stops": List<dynamic>.from(stops.map((x) => x.toJson())),
      };
}

class Stop {
  int id;
  double latitude;
  double longitude;

  Stop({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Vehicle {
  int id;
  String registrationNumber;
  String model;
  int seat;
  List<Image> images;

  Vehicle({
    required this.id,
    required this.registrationNumber,
    required this.model,
    required this.seat,
    required this.images,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        registrationNumber: json["registrationNumber"],
        model: json["model"],
        seat: json["seat"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registrationNumber": registrationNumber,
        "model": model,
        "seat": seat,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  String image;

  Image({
    required this.id,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
