import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class SalvarHeaderUsecase extends UseCase<bool, ParametrosSalvarHeader> {
  final Repositorio<bool, ParametrosSalvarHeader> repositorio;

  SalvarHeaderUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required ParametrosSalvarHeader parametros}) async {
    try {
      final resultado = await retornoRepositorio(
        repositorio: repositorio,
        erro: ErrorSalvarHeader(
          mensagem: "Erro ao salvar os dados do header Cod.01-2",
        ),
        parametros: parametros,
      );
      if (resultado is SucessoRetorno<bool>) {
        if (!resultado.resultado) {
          return ErroRetorno(
            erro: ErrorSalvarHeader(
              mensagem: "Erro ao salvar os dados do header Cod.01-1",
            ),
          );
        }
      }
      return resultado;
    } catch (e) {
      return ErroRetorno(
        erro: ErrorSalvarHeader(
          mensagem:
              "${e.toString()} - Erro ao salvar os dados do header Cod.01-3",
        ),
      );
    }
  }
}
