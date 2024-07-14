import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';

class GetLocApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetloc.p';

  Future<String> validateLoc(
      String dominio, String almacen, String ubicacion) async {
    final response = await dio.post(
      url,
      data: {
        "dsRequest": {
          "Ubicacion": [
            {
              "Domain": "$dominio",
              "Almacen": "$almacen",
              "Ubicacion": "$ubicacion",
              "Descripcion": ""
            }
          ]
        }
      },
    );

    //final validateLocResponse = ArticuloModel.fromJson(response.data);

    print(response.data);

    final validateLocResponse = UbicacionModel.fromJson(response.data);

    print(validateLocResponse.ubicacion[0].descripcion);

    return validateLocResponse.ubicacion[0].descripcion;
  }
}
