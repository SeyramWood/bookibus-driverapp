import 'package:bookihub/src/features/delivery/domain/repository/deliver_repo.dart';
import 'package:bookihub/src/shared/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../shared/utils/usecase.dart';

class VerifyPackageCode
    extends UseCase<String, MultiParams<String, String, String>> {
  final DeliveryRepo repo;

  VerifyPackageCode(this.repo);
  @override
  Future<Either<Failure, String>> call(
      MultiParams<String, String, String> params) async {
    return await repo.verifyPackageCode(params.data1, params.data2);
  }
}
