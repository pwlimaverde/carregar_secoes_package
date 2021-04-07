import '../../carregar_secoes_package.dart';

class ResultadoSecao {
  final String nome;
  final String img;
  final int prioridade;
  final bool scrow;
  final Map cor;
  final Stream<List<ResultadoAnuncio>> anuncios;

  ResultadoSecao({
    required this.nome,
    required this.img,
    required this.prioridade,
    required this.scrow,
    required this.cor,
    required this.anuncios,
  });

  @override
  String toString() {
    return "Dados - $nome, $cor, ${anuncios.length} anuncios";
  }
}
