import 'package:return_success_or_error/return_success_or_error.dart';

class ErrorCarregarSecoes implements AppError {
  String message;
  ErrorCarregarSecoes({required this.message});

  @override
  String toString() {
    return "ErrorCarregarSecoes - $message";
  }
}

class ErrorSalvarHeader implements AppError {
  String message;
  ErrorSalvarHeader({required this.message});

  @override
  String toString() {
    return "ErrorSalvarHeader - $message";
  }
}
