import 'package:carregar_secoes_package/src/presenter/salvar_header_presenter.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FairebaseSalvarHeaderDatasourceMock extends Mock
    implements Datasource<bool, ParametrosSalvarHeader> {}

void main() {
  late Datasource<bool, ParametrosSalvarHeader> datasource;

  setUp(() {
    datasource = FairebaseSalvarHeaderDatasourceMock();
  });

  test('Deve retornar um sucesso com true', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final result = await SalvarHeaderPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarHeader(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
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
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.01-1',
      () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(false));
    final result = await SalvarHeaderPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarHeader(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await SalvarHeaderPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarHeader(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
