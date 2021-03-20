import 'package:return_success_or_error/return_success_or_error.dart';

class CarregarImagemDaGaleriaPresenter {
  final Datasource<bool> datasource;
  final bool mostrarTempoExecucao;

  CarregarImagemDaGaleriaPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<ReturnSuccessOrError<bool>> salvarImagem(
      {required ParametersReturnResult parameters}) async {
    final resultado = await ReturnResultPresenter<bool>(
      showRuntimeMilliseconds: mostrarTempoExecucao,
      nameFeature:
          "Carregar imagem da galeria e atualizar imagem do header das seções",
      datasource: datasource,
    )(
      parameters: parameters,
    );
    return resultado;
  }
}
