// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

import '../../../../shared/constant/model.dart';
import '../../../trip/domain/entities/trip_model.dart';

DeliveryModel deliveryModelFromJson(String str) => DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryModel {
    Data data;
    bool status;

    DeliveryModel({
        required this.data,
        required this.status,
    });

    factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    int id;
    String packageCode;
    String senderName;
    String senderPhone;
    String recipientName;
    String recipientPhone;
    String recipientLocation;
    int amount;
    String transType;
    String status;
    List<VImage> packageImages;
    List<dynamic> recipientImages;
    Trip trip;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.packageCode,
        required this.senderName,
        required this.senderPhone,
        required this.recipientName,
        required this.recipientPhone,
        required this.recipientLocation,
        required this.amount,
        required this.transType,
        required this.status,
        required this.packageImages,
        required this.recipientImages,
        required this.trip,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        packageCode: json["packageCode"],
        senderName: json["senderName"],
        senderPhone: json["senderPhone"],
        recipientName: json["recipientName"],
        recipientPhone: json["recipientPhone"],
        recipientLocation: json["recipientLocation"],
        amount: json["amount"],
        transType: json["transType"],
        status: json["status"],
        packageImages: List<VImage>.from(json["packageImages"].map((x) => VImage.fromJson(x))),
        recipientImages: List<dynamic>.from(json["recipientImages"].map((x) => x)),
        trip: Trip.fromJson(json["trip"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "packageCode": packageCode,
        "senderName": senderName,
        "senderPhone": senderPhone,
        "recipientName": recipientName,
        "recipientPhone": recipientPhone,
        "recipientLocation": recipientLocation,
        "amount": amount,
        "transType": transType,
        "status": status,
        "packageImages": List<dynamic>.from(packageImages.map((x) => x.toJson())),
        "recipientImages": List<dynamic>.from(recipientImages.map((x) => x)),
        "trip": trip.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
