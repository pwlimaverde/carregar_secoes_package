import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class CarregarImagemDoLinkPresenter {
  final Datasource<bool, ParametrosRetornoResultado> datasource;
  final bool mostrarTempoExecucao;

  CarregarImagemDoLinkPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<bool>> salvarImagem(
      {required ParametrosRetornoResultado parametros}) async {
    final resultado = await RetornoResultadoPresenter<bool>(
      mostrarTempoExecucao: mostrarTempoExecucao,
      nomeFeature:
          "Carregar imagem do link e atualizar imagem do header das seções",
      datasource: datasource,
    ).retornoResultado(
      parametros: parametros,
    );
    return resultado;
  }
}
