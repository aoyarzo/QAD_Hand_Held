// To parse this JSON data, do
//
//     final almacenModel = almacenModelFromJson(jsonString);

import 'dart:convert';

AlmacenModel almacenModelFromJson(String str) => AlmacenModel.fromJson(json.decode(str));

String almacenModelToJson(AlmacenModel data) => json.encode(data.toJson());

class AlmacenModel {
    final List<Almacen> almacen;

    AlmacenModel({
        required this.almacen,
    });

    factory AlmacenModel.fromJson(Map<String, dynamic> json) => AlmacenModel(
        almacen: List<Almacen>.from(json["Almacen"].map((x) => Almacen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Almacen": List<dynamic>.from(almacen.map((x) => x.toJson())),
    };
}

class Almacen {
    final String domain;
    final String almacen;
    final String descripcion;

    Almacen({
        required this.domain,
        required this.almacen,
        required this.descripcion,
    });

    factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
        domain: json["Domain"],
        almacen: json["Almacen"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "Domain": domain,
        "Almacen": almacen,
        "Descripcion": descripcion,
    };
}
