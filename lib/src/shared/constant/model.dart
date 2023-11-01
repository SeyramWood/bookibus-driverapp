
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
        "exterior": '$exterior',
        "interior": '$interior',
        "engineCompartment": '$engineCompartment',
        "brakeAndSteering": '$brakeAndSteering',
        "emergencyEquipment": '$emergencyEquipment',
        "fuelAndFluid": '$fuelAndFluid',
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
  List<VImage> images;

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
        images:
            List<VImage>.from(json["images"].map((x) => VImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registrationNumber": registrationNumber,
        "model": model,
        "seat": seat,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class VImage {
  int id;
  String image;

  VImage({
    required this.id,
    required this.image,
  });

  factory VImage.fromJson(Map<String, dynamic> json) => VImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
