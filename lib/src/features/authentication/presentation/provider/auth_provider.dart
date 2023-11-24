import 'package:bookihub/src/features/authentication/domain/usecase/login.dart';
import 'package:bookihub/src/shared/errors/failure.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class AuthProvider extends ChangeNotifier {
  String? _user;
  get user => _user;
  final Login _login;
  AuthProvider({required Login login}) : _login = login;
  bool _isLoading = false;
  bool get isloading => _isLoading;

  Future<Either<Failure, String>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final result = await _login(MultiParams(email, password));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return Left(Failure(failure.message));
      },
      (success) {
        _isLoading = false;
        _user = success;
        notifyListeners();
        return Right(success);
      },
    );
  }
}
