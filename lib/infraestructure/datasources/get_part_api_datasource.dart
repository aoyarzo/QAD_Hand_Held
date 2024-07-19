import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/transferencia_inventario/articulos_model.dart';

class GetPartApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetparts';

  Future<List<Articulo>> validatePart(String dominio, String articulo) async {
    final response = await dio.post(
      url,
      data: {
        "dsRequest": {
          "Articulos": [
            {
              "Domain": "$dominio",
              "Articulo": "$articulo",
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

    //print(response.data);

    return validatePartResponse.articulos;
  }
}
