import 'package:carregar_secoes_package/src/repositories/salvar_header_repository.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FairebaseSalvarHeaderDatasourceMock extends Mock
    implements Datasource<bool, ParametrosSalvarHeader> {}

void main() {
  late Datasource<bool, ParametrosSalvarHeader> datasource;
  late Repositorio<bool, ParametrosSalvarHeader> repositorio;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    datasource = FairebaseSalvarHeaderDatasourceMock();
    repositorio = SalvarHeaderRepositorio(datasource: datasource);
  });

  test('Deve retornar um sucesso com true', () async {
    tempo.iniciar();
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final result = await repositorio(
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
    tempo.terminar();
    print("Tempo de Execução do SalvarHeader: ${tempo.calcularExecucao()}ms");
    expect(result, isA<SucessoRetorno<bool>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        true);
  });

  test('Deve retornar um sucesso com false', () async {
    tempo.iniciar();
    when(datasource).calls(#call).thenAnswer((_) => Future.value(false));
    final result = await repositorio(
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
    tempo.terminar();
    print("Tempo de Execução do SalvarHeader: ${tempo.calcularExecucao()}ms");
    expect(result, isA<SucessoRetorno<bool>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        false);
  });

  test(
      'Deve retornar ErrorSalvarHeader com Erro ao salvar os dados do header Cod.02-1',
      () async {
    tempo.iniciar();
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await repositorio(
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
    tempo.terminar();
    print("Tempo de Execução do SalvarHeader: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
