import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../utilitarios/erros_carregar_secoes.dart';
import 'entities/resultado_secao.dart';

class CarregarSecoesUsecase
    extends UseCase<Stream<List<ResultadoSecao>>, NoParams> {
  final Repositorio<Stream<List<ResultadoSecao>>, NoParams> repositorio;

  CarregarSecoesUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<Stream<List<ResultadoSecao>>>> call(
      {required NoParams parametros}) async {
    try {
      final resultado = await retornoRepositorio(
        repositorio: repositorio,
        erro: ErrorCarregarSecoes(
            mensagem: "Erro ao carregar os dados das Seções Cod.01-1"),
        parametros: NoParams(),
      );
      return resultado;
    } catch (e) {
      return ErroRetorno(
        erro: ErrorCarregarSecoes(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados das Seções Cod.01-2",
        ),
      );
    }
  }
}
