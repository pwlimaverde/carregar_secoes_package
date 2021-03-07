import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../carregar_secoes_package.dart';

class CarregarSecoesPresenter {
  final Datasource<Stream<List<ResultadoSecao>>, ParametrosRetornoResultado>
      datasource;
  final bool mostrarTempoExecucao;

  CarregarSecoesPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<Stream<List<ResultadoSecao>>>>
      carregarSecoes() async {
    final resultado =
        await RetornoResultadoPresenter<Stream<List<ResultadoSecao>>>(
      mostrarTempoExecucao: mostrarTempoExecucao,
      nomeFeature: "Carregar Seções",
      datasource: datasource,
    ).retornoResultado(
      parametros: NoParams(
        mensagemErro: "Erro ao carregar os dados das Seções",
      ),
    );
    return resultado;
  }
}
