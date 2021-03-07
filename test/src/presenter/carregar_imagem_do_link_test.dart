import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FairebaseCarregarImagemDoLinkDatasourceMock extends Mock
    implements Datasource<bool, ParametrosCarregarImagemDoLink> {}

void main() {
  late Datasource<bool, ParametrosCarregarImagemDoLink> datasource;

  setUp(() {
    datasource = FairebaseCarregarImagemDoLinkDatasourceMock();
  });

  test('Deve retornar um sucesso com true', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final result = await CarregarImagemDoLinkPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarImagem(
      parametros: ParametrosCarregarImagemDoLink(
        secao: ResultadoSecao(
          cor: {
            "r": 60,
            "g": 60,
            "b": 60,
          },
          nome: 'novidades',
          prioridade: 1,
          img: 'img',
          scrow: true,
        ),
        link: 'link',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        true);
  });

  test(
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarImagemDoLinkPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarImagem(
      parametros: ParametrosCarregarImagemDoLink(
        secao: ResultadoSecao(
          cor: {
            "r": 60,
            "g": 60,
            "b": 60,
          },
          nome: 'novidades',
          prioridade: 1,
          img: 'img',
          scrow: true,
        ),
        link: 'link',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
