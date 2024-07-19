import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/ajuste_inv/ajuste_inv_model.dart';

class AjusInvDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputinvcicl.p';

  Future<List<Respuesta>> ajusInv(
      String dominio, String articulo, String almacen, String ubicacion,
      String lote, String referencia, double cantidad, String usuario) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "$dominio",
      "TipAjust": false,
      "Articulo": "$articulo",
      "Almacen": "$almacen",
      "Ubicacion": "$ubicacion",
      "Lote": "$lote",
      "Referencia": "$referencia",
      "Cantidad": cantidad,
      "Usuario": "$usuario"
    }
  ]
}}
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    final ajusteInvResponse = AjusteInvModel.fromJson(response.data);

    print(ajusteInvResponse.respuesta[0].mensaje);

    return ajusteInvResponse.respuesta;
  }
}
