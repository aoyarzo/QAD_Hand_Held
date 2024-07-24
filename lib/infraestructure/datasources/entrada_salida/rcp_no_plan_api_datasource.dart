import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/entrada_salida/entrada_salida_model.dart';

class RcpNoPlanDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputrcpnoplan.p';

  Future<List<Respuesta>> rcpNoPlan(
      String dominio, String articulo, String almacen, String ubicacion,
      String lote, String referencia, double cantidad) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "$dominio",
      "Articulo": "$articulo",
      "Cantidad": "$cantidad",
      "Almacen": "$almacen",
      "Ubicacion": "$ubicacion",
      "Lote": "$lote",
      "Referencia": "$referencia"
    }
  ]
}}
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response);

    final entradaResponse = EntradaSalidaModel.fromJson(response.data);

    print(entradaResponse.respuesta[0].mensaje);

    return entradaResponse.respuesta;
  }
}
