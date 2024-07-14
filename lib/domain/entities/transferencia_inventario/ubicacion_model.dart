// To parse this JSON data, do
//
//     final ubicacionModel = ubicacionModelFromJson(jsonString);

import 'dart:convert';

UbicacionModel ubicacionModelFromJson(String str) => UbicacionModel.fromJson(json.decode(str));

String ubicacionModelToJson(UbicacionModel data) => json.encode(data.toJson());

class UbicacionModel {
    final List<Ubicacion> ubicacion;

    UbicacionModel({
        required this.ubicacion,
    });

    factory UbicacionModel.fromJson(Map<String, dynamic> json) => UbicacionModel(
        ubicacion: List<Ubicacion>.from(json["Ubicacion"].map((x) => Ubicacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Ubicacion": List<dynamic>.from(ubicacion.map((x) => x.toJson())),
    };
}

class Ubicacion {
    final String domain;
    final String almacen;
    final String ubicacion;
    final String descripcion;

    Ubicacion({
        required this.domain,
        required this.almacen,
        required this.ubicacion,
        required this.descripcion,
    });

    factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        domain: json["Domain"],
        almacen: json["Almacen"],
        ubicacion: json["Ubicacion"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "Domain": domain,
        "Almacen": almacen,
        "Ubicacion": ubicacion,
        "Descripcion": descripcion,
    };
}
