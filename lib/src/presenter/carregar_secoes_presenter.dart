import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../repositories/carregar_secoes_repository.dart';
import '../usecases/carregar_secoes_usecase.dart';
import '../usecases/entities/resultado_secao.dart';

class CarregarSecoesPresenter {
  final Datasource<Stream<List<ResultadoSecao>>, NoParams> datasource;
  final bool mostrarTempoExecucao;

  CarregarSecoesPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<Stream<List<ResultadoSecao>>>>
      carregarSecoes() async {
    TempoExecucao tempo = TempoExecucao();
    if (mostrarTempoExecucao) {
      tempo.iniciar();
    }
    final resultado = await CarregarSecoesUsecase(
      repositorio: CarregarSecoesRepositorio(
        datasource: datasource,
      ),
    )(parametros: NoParams());
    if (mostrarTempoExecucao) {
      tempo.terminar();
      print(
          "Tempo de Execução do CarregarSecoesPresenter: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }
}
