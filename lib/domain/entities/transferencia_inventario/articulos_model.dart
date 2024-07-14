// To parse this JSON data, do
//
//     final articuloModel = articuloModelFromJson(jsonString);

import 'dart:convert';

ArticuloModel articuloModelFromJson(String str) => ArticuloModel.fromJson(json.decode(str));

String articuloModelToJson(ArticuloModel data) => json.encode(data.toJson());

class ArticuloModel {
    final List<Articulo> articulos;

    ArticuloModel({
        required this.articulos,
    });

    factory ArticuloModel.fromJson(Map<String, dynamic> json) => ArticuloModel(
        articulos: List<Articulo>.from(json["Articulos"].map((x) => Articulo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Articulos": List<dynamic>.from(articulos.map((x) => x.toJson())),
    };
}

class Articulo {
    final String domain;
    final String articulo;
    final String descripcion;
    final String um;
    final String almacen;
    final String estatus;

    Articulo({
        required this.domain,
        required this.articulo,
        required this.descripcion,
        required this.um,
        required this.almacen,
        required this.estatus,
    });

    factory Articulo.fromJson(Map<String, dynamic> json) => Articulo(
        domain: json["Domain"],
        articulo: json["Articulo"],
        descripcion: json["Descripcion"],
        um: json["UM"],
        almacen: json["Almacen"],
        estatus: json["Estatus"],
    );

    Map<String, dynamic> toJson() => {
        "Domain": domain,
        "Articulo": articulo,
        "Descripcion": descripcion,
        "UM": um,
        "Almacen": almacen,
        "Estatus": estatus,
    };
}
