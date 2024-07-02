import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/articulos_model.dart';

Future<void> validatePart() async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      'https://aramark-pilo.qad.cl/apierp/apigetparts',
      data: {
        "dsRequest": {
          "Articulos": [
            {
              "Domain": "Aramark",
              "Articulo": "A000426",
              "Descripcion": "",
              "UM": "",
              "Almacen": "",
              "Estatus": ""
            },
            {
              "Domain": "Aramark",
              "Articulo": "A000833",
              "Descripcion": "",
              "UM": "",
              "Almacen": "",
              "Estatus": ""
            }
          ]
        }
      },
    );
    print(response.data);
  } catch (e) {
    print(e.toString());
  }
}

class GetPartApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetparts';

  Future<void> validatePart() async {
    final response = await dio.post(
      url,
      data: {
        "dsRequest": {
          "Articulos": [
            {
              "Domain": "Aramark",
              "Articulo": "A000426",
              "Descripcion": "",
              "UM": "",
              "Almacen": "",
              "Estatus": ""
            },
            {
              "Domain": "Aramark",
              "Articulo": "A000833",
              "Descripcion": "",
              "UM": "",
              "Almacen": "",
              "Estatus": ""
            }
          ]
        }
      },
    );

    final validatePartResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    for (int i = 0; i < validatePartResponse.articulos.length; i++) {
      print(validatePartResponse.articulos[i].articulo);
      print(validatePartResponse.articulos[i].descripcion);
    }

  }
}
