import 'package:carregar_secoes_package/src/presenter/salvar_header_presenter.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

class FairebaseSalvarHeaderDatasourceMock extends Mock
    implements Datasource<bool> {}

void main() {
  late Datasource<bool> datasource;

  setUp(() {
    datasource = FairebaseSalvarHeaderDatasourceMock();
  });

  test('Deve retornar um sucesso com true', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final result = await SalvarHeaderPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarHeader(
      parameters: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
        error: ErrorSalvarHeader(message: "Teste erro"),
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
  });

  test(
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await SalvarHeaderPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).salvarHeader(
      parameters: ParametrosSalvarHeader(
          corHeader: {
            "r": 60,
            "g": 60,
            "b": 60,
          },
          doc: 'testedoc',
          nome: 'novidades',
          prioridade: 1,
          user: 'paulo',
          error: ErrorSalvarHeader(message: "Teste erro")),
    );
    print("teste result - ${await result.fold(
      success: (value) => value.result,
      error: (value) => value.error,
    )}");
    expect(result, isA<ErrorReturn<bool>>());
  });
}
