import 'package:return_success_or_error/return_success_or_error.dart';

class SalvarHeaderPresenter {
  final Datasource<bool> datasource;
  final bool mostrarTempoExecucao;

  SalvarHeaderPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<ReturnSuccessOrError<bool>> salvarHeader(
      {required ParametersReturnResult parameters}) async {
    final resultado = await ReturnResultPresenter<bool>(
      showRuntimeMilliseconds: mostrarTempoExecucao,
      nameFeature: "Atualizar header das seções",
      datasource: datasource,
    )(
      parameters: parameters,
    );
    return resultado;
  }
}
