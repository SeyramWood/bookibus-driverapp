import 'package:bookihub/src/features/reports/domain/usecase/make_report.dart';
import 'package:bookihub/src/shared/errors/failure.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/report_model.dart';

class ReportProvider extends ChangeNotifier {
  final MakeReport _makeReport;

  ReportProvider({required MakeReport makeReport}) : _makeReport = makeReport;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(loading) {
    _isLoading = loading;
  }

  Future<Either<Failure, String>> makeReport(
      String companyId, ReportModel report) async {
    _isLoading = true;
    notifyListeners();
    final result = await _makeReport(MultiParams(companyId, report));
    return result.fold((failure) {
      _isLoading = false;
    notifyListeners();
      return Left(Failure(failure.message));
    }, (success) {
      _isLoading = false;
      notifyListeners();
      return Right(success);
    });
  }
}
