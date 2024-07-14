import 'dart:convert';

RecepcionModel recepcionModelFromJson(String str) => RecepcionModel.fromJson(json.decode(str));

String recepcionModelToJson(RecepcionModel data) => json.encode(data.toJson());

class RecepcionModel {
    final List<Respuesta> respuesta;

    RecepcionModel({
        required this.respuesta,
    });

    factory RecepcionModel.fromJson(Map<String, dynamic> json) => RecepcionModel(
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
