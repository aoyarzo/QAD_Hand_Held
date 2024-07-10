// To parse this JSON data, do
//
//     final transfResponseModel = transfResponseModelFromJson(jsonString);

import 'dart:convert';

TransfResponseModel transfResponseModelFromJson(String str) => TransfResponseModel.fromJson(json.decode(str));

String transfResponseModelToJson(TransfResponseModel data) => json.encode(data.toJson());

class TransfResponseModel {
    final List<Respuesta> respuesta;

    TransfResponseModel({
        required this.respuesta,
    });

    factory TransfResponseModel.fromJson(Map<String, dynamic> json) => TransfResponseModel(
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
