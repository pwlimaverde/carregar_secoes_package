import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ErrorCarregarSecoes implements AppErro {
  final String mensagem;
  ErrorCarregarSecoes({required this.mensagem});

  @override
  String toString() {
    return "ErrorCarregarSecoes - $mensagem";
  }
}

class ErrorSalvarHeader implements AppErro {
  final String mensagem;
  ErrorSalvarHeader({required this.mensagem});

  @override
  String toString() {
    return "ErrorSalvarHeader - $mensagem";
  }
}
