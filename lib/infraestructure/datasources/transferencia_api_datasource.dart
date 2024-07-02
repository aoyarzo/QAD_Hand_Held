import 'package:dio/dio.dart';

class TransferenciaApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apiputtransfer';

  Future<void> transferencia() async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "Registros": [
    {
      "Dominio": "aramark",
      "Articulo": "Articulo",
      "AlmOrig": "Planta",
      "UbiOrig": "Ubica",
      "LotOrig": "Lte",
      "RefOrig": "Ref",
      "AlmDest": "Planta",
      "UbiDest": "Ubi01",
      "LotDest": "Lte",
      "Ref Des": "Ref",
      "Cantidad": 10.0
    },
    {
      "Dominio": "aramark",
      "Articulo": "Articulo1",
      "AlmOrig": "Planta",
      "UbiOrig": "Ubica",
      "LotOrig": "Lte",
      "RefOrig": "Ref",
      "AlmDest": "Planta",
      "UbiDest": "Ubi01",
      "LotDest": "Lte",
      "Ref Des": "Ref",
      "Cantidad": 11.0
    }
  ]
}},
    );

    //final validatePartResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

  }
}
