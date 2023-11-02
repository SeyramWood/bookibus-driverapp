import 'package:bookihub/src/features/reports/domain/entities/report_model.dart';
import 'package:bookihub/src/features/trip/data/api/api_service.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';

import '../../../../shared/constant/base_url.dart';
import 'package:http/http.dart' as http;

class ReportApiService {
  Future makeReport(String companyId, ReportModel report) async {
    final url = "$baseUrl/incidents/company/$companyId";
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['time'] = report.time;
      request.fields['location'] = report.location;
      request.fields['description'] = report.description;
      request.fields['tripId'] = '${report.tripId}';
      request.fields['driverId'] = '${report.driverId}';
      if (report.voiceNote == null) {
        request.files.add(
          http.MultipartFile.fromString('image', report.voiceNote!),
        );
      }
      for (var file in report.images) {
        request.files.add(
           http.MultipartFile.fromString('image', file.image),
        );
      }
      final response = await client.sendMultipartRequest(request: request);
      if (response.statusCode != 201) {
        print(response.statusCode);
        throw CustomException('${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
