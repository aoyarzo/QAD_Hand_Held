import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';

class TransferenciaApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputtransfer';

  Future<List<Respuesta>> transferencia( String dominio, String articulo, 
  String almOrig, String ubiOrig, String lotOrig, String almDest, 
  String ubicDest, String refOrig, int cantidad, String usuario) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "$dominio",
      "Articulo": "$articulo",
      "AlmOrig": "$almOrig",
      "UbiOrig": "$ubiOrig",
      "LotOrig": "$lotOrig",
      "RefOrig": "$refOrig",
      "AlmDest": "$almDest",
      "UbiDest": "$ubicDest",
      "LotDest": "$lotOrig",
      "Ref Des": "$refOrig",
      "Cantidad": cantidad,
      "Usuario": "$usuario"
    }
  ]
}},
    );

    final validateTransResponse = TransfResponseModel.fromJson(response.data);

    print(response.data);

    return validateTransResponse.respuesta;

  }
}
