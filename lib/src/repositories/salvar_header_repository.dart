import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class SalvarHeaderRepositorio
    extends Repositorio<bool, ParametrosSalvarHeader> {
  final Datasource<bool, ParametrosSalvarHeader> datasource;

  SalvarHeaderRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required ParametrosSalvarHeader parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErrorSalvarHeader(
        mensagem: "Erro ao salvar os dados do header Cod.02-1",
      ),
      parametros: parametros,
    );
    return resultado;
  }
}
