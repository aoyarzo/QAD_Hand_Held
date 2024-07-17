import 'dart:convert';

ArticuloDescModel articuloDescModelFromJson(String str) => ArticuloDescModel.fromJson(json.decode(str));

String articuloDescModelToJson(ArticuloDescModel data) => json.encode(data.toJson());

class ArticuloDescModel {
    final List<OCompra> oCompra;

    ArticuloDescModel({
        required this.oCompra,
    });

    factory ArticuloDescModel.fromJson(Map<String, dynamic> json) => ArticuloDescModel(
        oCompra: List<OCompra>.from(json["OCompra"].map((x) => OCompra.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OCompra": List<dynamic>.from(oCompra.map((x) => x.toJson())),
    };
}

class OCompra {
    final String domain;
    final String orden;
    final int linea;
    final String articulo;
    final String descripcion;
    final double cantAbta;
    final double precio;
    final String estatus;

    OCompra({
        required this.domain,
        required this.orden,
        required this.linea,
        required this.articulo,
        required this.descripcion,
        required this.cantAbta,
        required this.precio,
        required this.estatus,
    });

    factory OCompra.fromJson(Map<String, dynamic> json) => OCompra(
        domain: json["Domain"],
        orden: json["Orden"],
        linea: json["Linea"],
        articulo: json["Articulo"],
        descripcion: json["Descripcion"],
        cantAbta: json["Cant.Abta"]?.toDouble(),
        precio: json["Precio"]?.toDouble(),
        estatus: json["Estatus"],
    );

    Map<String, dynamic> toJson() => {
        "Domain": domain,
        "Orden": orden,
        "Linea": linea,
        "Articulo": articulo,
        "Descripcion": descripcion,
        "Cant.Abta": cantAbta,
        "Precio": precio,
        "Estatus": estatus,
    };
}
