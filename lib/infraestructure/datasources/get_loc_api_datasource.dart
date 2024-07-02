import 'package:dio/dio.dart';

class GetLocApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetloc.p';

  Future<void> validateLoc() async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Ubicacion": [
    {
      "Domain": "Aramark",
      "Almacen": "Alpes",
      "Ubicacion": "ABAR01",
      "Descripcion": ""
    },
    {
      "Domain": "Aramark",
      "Almacen": "Alpes",
      "Ubicacion": "ABAR02",
      "Descripcion": ""
    }
  ]
}},
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

   

  }
}
