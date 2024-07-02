// To parse this JSON data, do
//
//     final transferenciaModel = transferenciaModelFromJson(jsonString);

import 'dart:convert';

TransferenciaModel transferenciaModelFromJson(String str) => TransferenciaModel.fromJson(json.decode(str));

String transferenciaModelToJson(TransferenciaModel data) => json.encode(data.toJson());

class TransferenciaModel {
    final String dominio;
    final String articulo;
    final String almOrig;
    final String ubiOrig;
    final String lotOrig;
    final String refOrig;
    final String almDest;
    final String ubiDest;
    final String lotDest;
    final String refDes;
    final int cantidad;

    TransferenciaModel({
        required this.dominio,
        required this.articulo,
        required this.almOrig,
        required this.ubiOrig,
        required this.lotOrig,
        required this.refOrig,
        required this.almDest,
        required this.ubiDest,
        required this.lotDest,
        required this.refDes,
        required this.cantidad,
    });

    factory TransferenciaModel.fromJson(Map<String, dynamic> json) => TransferenciaModel(
        dominio: json["Dominio"],
        articulo: json["Articulo"],
        almOrig: json["AlmOrig"],
        ubiOrig: json["UbiOrig"],
        lotOrig: json["LotOrig"],
        refOrig: json["RefOrig"],
        almDest: json["AlmDest"],
        ubiDest: json["UbiDest"],
        lotDest: json["LotDest"],
        refDes: json["Ref Des"],
        cantidad: json["Cantidad"],
    );

    Map<String, dynamic> toJson() => {
        "Dominio": dominio,
        "Articulo": articulo,
        "AlmOrig": almOrig,
        "UbiOrig": ubiOrig,
        "LotOrig": lotOrig,
        "RefOrig": refOrig,
        "AlmDest": almDest,
        "UbiDest": ubiDest,
        "LotDest": lotDest,
        "Ref Des": refDes,
        "Cantidad": cantidad,
    };
}
