import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';

class GetSiteApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetsite';

  Future<String> validateSite( String dominio, String almacen) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Almacen": [
    {
      "Domain": "$dominio",
      "Almacen": "$almacen",
      "Descripcion": ""
    }
  ]
}}
    );

    final validateSiteResponse = AlmacenModel.fromJson(response.data);

    //print(response.data);

    return validateSiteResponse.almacen[0].descripcion;
  }
}
