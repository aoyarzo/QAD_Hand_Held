import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/recepcion_oc/recepcion_model.dart';

class RpcOCDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputrecepoc.p';

  Future<List<Respuesta>> rpcOC(
      String dominio, String orden, String articulo, int linea, String proveedor, String efectiva,
      String documento, double cantAbta, double precioFactura, String almacen, String ubicacion, String lote, 
      String referencia, String fechaVenc, String usuario) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "$dominio",
      "Orden": "$orden",
      "Proveedor":"$proveedor",
      "Efectiva": "$efectiva",
      "Funda": "$documento",
      "Articulo": "$articulo",
      "Linea": linea,
      "Costo": precioFactura,
      "Cantidad": cantAbta,
      "Almacen": "$almacen",
      "Ubicacion": "$ubicacion",
      "Lote": "$lote",
      "Referencia": "$referencia",
      "FchVcto": "$fechaVenc",
      "Usuario": "$usuario"
    }
  ]
}}
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    final rpcOCResponse = RecepcionModel.fromJson(response.data);

    print(rpcOCResponse.respuesta[0].mensaje);

    return rpcOCResponse.respuesta;
  }
}
