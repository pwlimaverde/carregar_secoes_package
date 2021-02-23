import 'package:carregar_secoes_package/src/usecases/carregar_secoes_usecase.dart';
import 'package:carregar_secoes_package/src/usecases/entities/resultado_secao.dart';
import 'package:carregar_secoes_package/src/utilitarios/erros_carregar_secoes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class CarregarSecoesRepositorioMock extends Mock
    implements Repositorio<Stream<List<ResultadoSecao>>, NoParams> {}

void main() {
  late Repositorio<Stream<List<ResultadoSecao>>, NoParams> repositorio;
  late UseCase<Stream<List<ResultadoSecao>>, NoParams> carregarSecoesUsecase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    repositorio = CarregarSecoesRepositorioMock();
    carregarSecoesUsecase = CarregarSecoesUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com Stream<ResultadoSecoes>', () async {
    tempo.iniciar();
    final testeFire = BehaviorSubject<List<ResultadoSecao>>();
    List<ResultadoSecao> listaSecoes = [];
    listaSecoes.add(
      ResultadoSecao(
        nome: "Promoções",
        img: "link",
        prioridade: 2,
        scrow: true,
        cor: {"a": 50, "b": 30, "g": 60, "r": 40},
      ),
    );
    listaSecoes.add(
      ResultadoSecao(
        nome: "Novidades",
        img: "link2",
        prioridade: 1,
        scrow: true,
        cor: {"a": 255, "b": 240, "g": 30, "r": 90},
      ),
    );
    testeFire.add(listaSecoes);
    when(repositorio).calls(#call).thenAnswer((_) => Future.value(
        SucessoRetorno<Stream<List<ResultadoSecao>>>(resultado: testeFire)));
    final result = await carregarSecoesUsecase(parametros: NoParams());
    print("teste result - ${await result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
    tempo.terminar();
    print("Tempo de Execução do CarregarSecoes: ${tempo.calcularExecucao()}ms");
    expect(result, isA<SucessoRetorno<Stream<List<ResultadoSecao>>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<List<ResultadoSecao>>>());
    testeFire.close();
  });

  test(
      'Deve retornar um ErrorCarregarSecoes com Erro ao carregar os dados da Secoes Cod.02-1',
      () async {
    tempo.iniciar();

    when(repositorio).calls(#call).thenAnswer(
          (_) => Future.value(
            ErroRetorno<Stream<List<ResultadoSecao>>>(
              erro: ErrorCarregarSecoes(
                mensagem: "Erro ao carregar os dados da Secoes Cod.02-1",
              ),
            ),
          ),
        );
    final result = await carregarSecoesUsecase(parametros: NoParams());
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do CarregarSecoes: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<Stream<List<ResultadoSecao>>>>());
  });

  test(
      'Deve retornar um ErrorCarregarSecoes com Erro ao carregar os dados da Secoes Cod.01-1',
      () async {
    tempo.iniciar();

    when(repositorio).calls(#call).thenThrow(Exception());
    final result = await carregarSecoesUsecase(parametros: NoParams());
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do CarregarSecoes: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<Stream<List<ResultadoSecao>>>>());
  });
}
