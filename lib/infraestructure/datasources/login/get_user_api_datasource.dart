import 'package:dio/dio.dart';
import 'package:qad_hand_held/domain/entities/models.dart';


class GetUserApiDatasource {
  final dio = Dio();

  String url = 'https://aramark-pilo.qad.cl/apierp/apigetuser.p';

  Future<String> getUser(String usuario, String pass) async {
    final response = await dio.post(
      url,
      data: {"dsRequest": {
  "ValUser": [
    {
      "Usuario": "$usuario",
      "Passwd": "$pass",
      "Nombre": ""
    }
  ]
}}
    );

    final getUserResponse = UserModel.fromJson(response.data);

    //print(response.data);

    return getUserResponse.valUser[0].nombre;
  }
}
