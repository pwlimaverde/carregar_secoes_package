import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ParametrosSalvarHeader implements ParametrosRetornoResultado {
  final String doc;
  final String nome;
  final int prioridade;
  final Map<String, int> corHeader;
  final String user;

  ParametrosSalvarHeader({
    required this.doc,
    required this.nome,
    required this.prioridade,
    required this.corHeader,
    required this.user,
  });

  @override
  String get mensagemErro => "Erro ao atualizar os dados da seção";
}

class ParametrosCarregarImagemDaGaleria implements ParametrosRetornoResultado {
  final ResultadoSecao secao;

  ParametrosCarregarImagemDaGaleria({
    required this.secao,
  });

  @override
  String get mensagemErro => "Erro ao atualizar imagem da seção";
}

class ParametrosCarregarImagemDoLink implements ParametrosRetornoResultado {
  final ResultadoSecao secao;
  final String link;

  ParametrosCarregarImagemDoLink({
    required this.secao,
    required this.link,
  });

  @override
  String get mensagemErro => "Erro ao atualizar imagem da seção";
}
