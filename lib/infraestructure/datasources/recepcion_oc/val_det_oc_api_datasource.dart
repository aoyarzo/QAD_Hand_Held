import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/recepcion_oc/articulo_desc_model.dart';


class ValDetOCDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetdetoc.p';

  Future<List<OCompra>> validateDetOC(
      String dominio, String orden, String articulo) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "OCompra": [
    {
      "Domain": "$dominio",
      "Orden": "$orden",
      "Part":"$articulo",
      "Descrip":"",
      "QtyOpen":"",
      "Costo":"", 
      "Estatus": ""
    }
  ]
}}
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    final validateDetOCResponse = ArticuloDescModel.fromJson(response.data);

    print(validateDetOCResponse.oCompra[0].articulo);

    return validateDetOCResponse.oCompra;
  }
}
