import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:return_success_or_error/return_success_or_error.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseCarregarImagemDoLinkDatasourceMock extends Mock
    implements Datasource<bool> {}

void main() {
  late Datasource<bool> datasource;

  setUp(() {
    datasource = FairebaseCarregarImagemDoLinkDatasourceMock();
  });

  test('Deve retornar um sucesso com true', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final anuncios = BehaviorSubject<List<ResultadoAnuncio>>();
    anuncios.add([
      ResultadoAnuncio(
        image: "imagem",
        prioridade: 0,
        produto: 1,
        x: 1,
        y: 1,
      ),
      ResultadoAnuncio(
        image: "imagem2",
        prioridade: 1,
        produto: 2,
        x: 1,
        y: 1,
      ),
    ]);
    final result = await CarregarImagemDoLinkPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarImagem(
      parameters: ParametrosCarregarImagemDoLink(
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
        error: ErrorReturnResult(message: "Teste erro"),
      ),
    );
    print("teste result - ${await result.fold(
      success: (value) => value.result,
      error: (value) => value.error,
    )}");
    expect(result, isA<SuccessReturn<bool>>());
    expect(
        result.fold(
          success: (value) => value.result,
          error: (value) => value.error,
        ),
        true);
    anuncios.close();
  });

  test(
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final anuncios = BehaviorSubject<List<ResultadoAnuncio>>();
    anuncios.add([
      ResultadoAnuncio(
        image: "imagem",
        prioridade: 0,
        produto: 1,
        x: 1,
        y: 1,
      ),
      ResultadoAnuncio(
        image: "imagem2",
        prioridade: 1,
        produto: 2,
        x: 1,
        y: 1,
      ),
    ]);
    final result = await CarregarImagemDoLinkPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarImagem(
      parameters: ParametrosCarregarImagemDoLink(
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
        error: ErrorReturnResult(message: "Teste erro"),
      ),
    );
    print("teste result - ${await result.fold(
      success: (value) => value.result,
      error: (value) => value.error,
    )}");
    expect(result, isA<ErrorReturn<bool>>());
    anuncios.close();
  });
}
