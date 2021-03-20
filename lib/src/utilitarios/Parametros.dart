import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

class ParametrosSalvarHeader implements ParametersReturnResult {
  final String doc;
  final String nome;
  final int prioridade;
  final Map<String, int> corHeader;
  final String user;
  final AppError error;

  ParametrosSalvarHeader({
    required this.doc,
    required this.nome,
    required this.prioridade,
    required this.corHeader,
    required this.user,
    required this.error,
  });
}

class ParametrosCarregarImagemDaGaleria implements ParametersReturnResult {
  final ResultadoSecao secao;
  final AppError error;

  ParametrosCarregarImagemDaGaleria({
    required this.secao,
    required this.error,
  });
}

class ParametrosCarregarImagemDoLink implements ParametersReturnResult {
  final ResultadoSecao secao;
  final String link;
  final AppError error;

  ParametrosCarregarImagemDoLink({
    required this.secao,
    required this.link,
    required this.error,
  });
}
