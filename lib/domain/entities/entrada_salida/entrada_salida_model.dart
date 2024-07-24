import 'dart:convert';

EntradaSalidaModel entradaSalidaModelFromJson(String str) => EntradaSalidaModel.fromJson(json.decode(str));

String entradaSalidaModelToJson(EntradaSalidaModel data) => json.encode(data.toJson());

class EntradaSalidaModel {
    final List<Respuesta> respuesta;

    EntradaSalidaModel({
        required this.respuesta,
    });

    factory EntradaSalidaModel.fromJson(Map<String, dynamic> json) => EntradaSalidaModel(
        respuesta: List<Respuesta>.from(json["Respuesta"].map((x) => Respuesta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Respuesta": List<dynamic>.from(respuesta.map((x) => x.toJson())),
    };
}

class Respuesta {
    final String number;
    final String mensaje;
    final String severidad;

    Respuesta({
        required this.number,
        required this.mensaje,
        required this.severidad,
    });

    factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
        number: json["Number"],
        mensaje: json["Mensaje"],
        severidad: json["Severidad"],
    );

    Map<String, dynamic> toJson() => {
        "Number": number,
        "Mensaje": mensaje,
        "Severidad": severidad,
    };
}
