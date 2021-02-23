import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../usecases/entities/resultado_secao.dart';
import '../utilitarios/erros_carregar_secoes.dart';

class CarregarSecoesRepositorio
    extends Repositorio<Stream<List<ResultadoSecao>>, NoParams> {
  final Datasource<Stream<List<ResultadoSecao>>, NoParams> datasource;

  CarregarSecoesRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<List<ResultadoSecao>>>> call(
      {required NoParams parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErrorCarregarSecoes(
        mensagem: "Erro ao carregar os dados das Seções Cod.02-1",
      ),
      parametros: NoParams(),
    );
    return resultado;
  }
}
