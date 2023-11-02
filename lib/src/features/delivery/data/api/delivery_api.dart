import 'dart:convert';
import 'dart:io';

import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/trip/data/api/api_service.dart';
import 'package:bookihub/src/shared/constant/base_url.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class DeliveryApi {
  //fetch all delivery by a driver
  Future<List<Delivery>> fetchDelivery(String driverID, String status) async {
    final url = "$baseUrl/packages/driver/$driverID?status=$status";
    try {
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw CustomException('${response.reasonPhrase}');
      }
      return DeliveryModel.fromJson(jsonDecode(response.body)).data?.delivery ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<File>> selectFiles() async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      var files = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();

      // notifyListeners();
      return files;
    }
    return [];
  }

  Future verifyPackageCode(String packageId, String packageCode) async {
    var files = await selectFiles();
    final url = "$baseUrl/packages/$packageId/update-status";
    try {
      if (files.isNotEmpty) {
        final request = http.MultipartRequest('PUT', Uri.parse(url));
        request.fields['packageCode'] = packageCode;
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('image', file.path));
        }
        final response = await client.sendMultipartRequest(request: request);
        if (response.statusCode != 200) {
          throw CustomException('${response.reasonPhrase}');
        }
        print(response.body);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
