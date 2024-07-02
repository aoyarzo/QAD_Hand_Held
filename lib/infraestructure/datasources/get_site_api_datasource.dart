import 'package:dio/dio.dart';

class GetSiteApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetsite';

  Future<void> validateSite() async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Almacen": [
    {
      "Domain": "Aramark",
      "Almacen": "Alpes",
      "Descripcion": ""
    },
    {
      "Domain": "Aramark",
      "Almacen": "Alpes",
      "Descripcion": ""
    }
  ]
}},
    );

    //final validateSiteResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

  }
}
