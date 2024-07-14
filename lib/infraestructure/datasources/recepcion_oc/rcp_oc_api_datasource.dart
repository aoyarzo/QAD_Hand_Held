import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/recepcion_oc/recepcion_model.dart';

class ValDetOCDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputrecepoc.p';

  Future<String> rpcOC(
      String dominio, String orden, String articulo, String proveedor,
      String documento, String almacen, String ubicacion, String lote, 
      String referencia, String fechaVenc, String usuario) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "$dominio",
      "Orden": "$orden",
      "Proveedor":"",
      "Efectiva": "2024-07-10",
      "Funda": "GD3322",
      "Articulo": "$articulo",
      "Linea": 2,
      "Costo": 7852,
      "Cantidad": 5.0,
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

    return rpcOCResponse.respuesta[0].mensaje;
  }
}
