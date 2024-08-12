import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';

class ConsultaApiDatasource {
  final dio = Dio();

  Future<List<Consulta>> consuInv(String dominio, String articulo, String almacen,
      String detalle, String ubicacion) async {
    String url =
        'https://aramark-pilo.qad.cl/apierp/apigetinv2.p?DomainID=$dominio&ArticuloID=$articulo&AlmacenID=$almacen&DetalleID=$detalle&UbicacionID=$ubicacion';
    final response = await dio.get(url);

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    //print(url);
    print(response.data);

    final consultaResponse = ConsultaModel.fromJson(response.data);

    //print(ajusteInvResponse.respuesta[0].mensaje);

    return consultaResponse.consulta;
  }
}
