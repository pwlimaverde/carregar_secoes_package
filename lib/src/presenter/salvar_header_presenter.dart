import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../repositories/salvar_header_repository.dart';
import '../usecases/salvar_header_usecase.dart';
import '../utilitarios/Parametros.dart';

class SalvarHeaderPresenter {
  final Datasource<bool, ParametrosSalvarHeader> datasource;
  final bool mostrarTempoExecucao;

  SalvarHeaderPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<bool>> salvarHeader(
      {required ParametrosSalvarHeader parametros}) async {
    TempoExecucao tempo = TempoExecucao();
    if (mostrarTempoExecucao) {
      tempo.iniciar();
    }
    final resultado = await SalvarHeaderUsecase(
      repositorio: SalvarHeaderRepositorio(
        datasource: datasource,
      ),
    )(parametros: parametros);
    if (mostrarTempoExecucao) {
      tempo.terminar();
      print(
          "Tempo de Execução do SalvarHeaderPresenter: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }
}
