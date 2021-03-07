import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:carregar_secoes_package/src/presenter/carregar_secoes_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class CarregarSecoesDatasourceMock extends Mock
    implements Datasource<Stream<List<ResultadoSecao>>, NoParams> {}

void main() {
  late Datasource<Stream<List<ResultadoSecao>>, NoParams> datasource;

  setUp(() {
    datasource = CarregarSecoesDatasourceMock();
  });

  test('Deve retornar um sucesso com Stream<ResultadoSecoes>', () async {
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
    final result = await CarregarSecoesPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).carregarSecoes();
    print("teste result - ${await result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
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
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarSecoesPresenter(
      datasource: datasource,
      mostrarTempoExecucao: true,
    ).carregarSecoes();
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<Stream<List<ResultadoSecao>>>>());
  });
}
