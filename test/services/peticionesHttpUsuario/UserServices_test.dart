
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class MockClient extends Mock implements http.Client {}
void main(){
  /*
  late http.Client client;
  late UserService userServices;

  setUp(() {
    client = MockClient();
    // registerFallbackValue(Uri());
  });

  group("Pruebas del servicio UserServices", (){
    test("Prueba del metodo registrarUsuario cuando ", () {
      //arrange
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(productsTestObject), 200));
    });
  });
  */
}