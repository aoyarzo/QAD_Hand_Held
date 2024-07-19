import 'dart:convert';

AjusteInvModel ajusteInvModelFromJson(String str) => AjusteInvModel.fromJson(json.decode(str));

String ajusteInvModelToJson(AjusteInvModel data) => json.encode(data.toJson());

class AjusteInvModel {
    final List<Respuesta> respuesta;

    AjusteInvModel({
        required this.respuesta,
    });

    factory AjusteInvModel.fromJson(Map<String, dynamic> json) => AjusteInvModel(
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
