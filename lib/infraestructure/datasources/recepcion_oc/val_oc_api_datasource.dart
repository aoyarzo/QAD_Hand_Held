import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';

class ValOCApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetoc.p';

  Future<List<OCompra>> validateOC(
      String dominio, String orden) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "OCompra": [
    {
      "Domain": "$dominio",
      "Orden": "$orden",
      "CodProv":"",
      "Nombre":"", 
      "Estatus": ""
    }
  ]
}},
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    final validateOCResponse = OrdenModel.fromJson(response.data);

    print(validateOCResponse.oCompra[0].codProv);

    return validateOCResponse.oCompra;
  }
}
