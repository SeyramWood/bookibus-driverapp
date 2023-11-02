import 'package:bookihub/src/features/reports/domain/usecase/make_report.dart';
import 'package:bookihub/src/shared/errors/failure.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/report_model.dart';

class ReportProvider extends ChangeNotifier {
  final MakeReport _makeReport;

  ReportProvider({required MakeReport makeReport}) : _makeReport = makeReport;

  Future<Either<Failure, String>> makeReport(
      String companyId, ReportModel report) async {
    final result = await _makeReport(MultiParams(companyId, report));
    return result.fold((failure) => Left(Failure(failure.message)),
        (success) => Right(success));
  }
}
