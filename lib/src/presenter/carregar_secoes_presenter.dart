import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

import '../../carregar_secoes_package.dart';

class CarregarSecoesPresenter {
  final Datasource<Stream<List<ResultadoSecao>>> datasource;
  final bool mostrarTempoExecucao;

  CarregarSecoesPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<ReturnSuccessOrError<Stream<List<ResultadoSecao>>>>
      carregarSecoes() async {
    final resultado = await ReturnResultPresenter<Stream<List<ResultadoSecao>>>(
      showRuntimeMilliseconds: mostrarTempoExecucao,
      nameFeature: "Carregar Seções",
      datasource: datasource,
    )(
      parameters: NoParams(
        error: ErrorCarregarSecoes(message: "Erro ao carregar as seções"),
      ),
    );
    return resultado;
  }
}
