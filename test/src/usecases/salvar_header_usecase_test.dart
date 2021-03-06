import 'package:carregar_secoes_package/src/usecases/salvar_header_usecase.dart';
import 'package:carregar_secoes_package/src/utilitarios/Parametros.dart';
import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class SalvarHeaderRepositorioMock extends Mock
    implements Repositorio<bool, ParametrosSalvarHeader> {}

void main() {
  late Repositorio<bool, ParametrosSalvarHeader> repositorio;
  late UseCase<bool, ParametrosSalvarHeader> salvarHeaderUsecase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    repositorio = SalvarHeaderRepositorioMock();
    salvarHeaderUsecase = SalvarHeaderUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com bool', () async {
    tempo.iniciar();
    when(repositorio)
        .calls(#call)
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));
    final result = await salvarHeaderUsecase(
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

  test(
      'Deve retornar um ErrorSalvarHeader com Erro ao salvar os dados do header Cod.01-1',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenAnswer(
        (_) => Future.value(SucessoRetorno<bool>(resultado: false)));
    final result = await salvarHeaderUsecase(
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
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErrorSalvarHeader com Erro ao salvar os dados do header Cod.01-2',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenAnswer(
          (_) => Future.value(
            ErroRetorno<bool>(
              erro: ErrorSalvarHeader(
                mensagem: "Erro ao salvar os dados do header Cod.01-2",
              ),
            ),
          ),
        );
    final result = await salvarHeaderUsecase(
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
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErrorSalvarHeader, pela exeption do repositorio com Erro ao salvar os dados do header Cod.01-2',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenThrow(Exception());
    final result = await salvarHeaderUsecase(
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
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
