import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class SalvarHeaderPresenter {
  final Datasource<bool, ParametrosRetornoResultado> datasource;
  final bool mostrarTempoExecucao;

  SalvarHeaderPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<bool>> salvarHeader(
      {required ParametrosRetornoResultado parametros}) async {
    final resultado = await RetornoResultadoPresenter<bool>(
      mostrarTempoExecucao: mostrarTempoExecucao,
      nomeFeature: "Atualizar header das seções",
      datasource: datasource,
    ).retornoResultado(
      parametros: parametros,
    );
    return resultado;
  }
}
