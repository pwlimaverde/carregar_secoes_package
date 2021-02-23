import 'package:carregar_secoes_package/src/repositories/carregar_secoes_repository.dart';
import 'package:carregar_secoes_package/src/usecases/entities/resultado_secao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class CarregarSecoesDatasourceMock extends Mock
    implements Datasource<Stream<List<ResultadoSecao>>, NoParams> {}

void main() {
  late Datasource<Stream<List<ResultadoSecao>>, NoParams> datasource;
  late Repositorio<Stream<List<ResultadoSecao>>, NoParams> repositorio;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    datasource = CarregarSecoesDatasourceMock();
    repositorio = CarregarSecoesRepositorio(datasource: datasource);
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
    when(datasource).calls(#call).thenAnswer((_) => Future.value(testeFire));
    final result = await repositorio(parametros: NoParams());
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
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await repositorio(parametros: NoParams());
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do CarregarSecoes: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<Stream<List<ResultadoSecao>>>>());
  });
}
