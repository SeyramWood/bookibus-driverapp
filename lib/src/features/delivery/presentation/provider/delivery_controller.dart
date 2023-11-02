import 'package:bookihub/src/features/delivery/domain/entities/delivery_model.dart';
import 'package:bookihub/src/features/delivery/domain/usecase/deliver_package.dart';
import 'package:bookihub/src/features/delivery/domain/usecase/fetch_delivery.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../../domain/usecase/deliver_package.dart';

class DeliveryProvider extends ChangeNotifier {
  final FetchDelivery _fetchDelivery;
  final VerifyPackageCode _verifyPackageCode;

  DeliveryProvider(
      {required FetchDelivery fetchDelivery,
      required VerifyPackageCode verifyPackageCode})
      : _fetchDelivery = fetchDelivery,
        _verifyPackageCode = verifyPackageCode;

  Future<Either<Failure, List<Delivery>>> fetchDelivery(
      String driverID, String status) async {
    final result = await _fetchDelivery(MultiParams(driverID, status));
    return result.fold(
      (failure) => Left(Failure(failure.message)),
      (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, String>> verifyPackageCode(
      String packageId, String packageCode) async {
    final result =
        await _verifyPackageCode(MultiParams(packageId, packageCode));
    return result.fold(
      (failure) => Left(Failure(failure.message)),
      (success) {
        return Right(success);
      },
    );
  }
}
