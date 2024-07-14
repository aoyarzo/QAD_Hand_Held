import 'dart:convert';

OrdenModel ordenModelFromJson(String str) => OrdenModel.fromJson(json.decode(str));

String ordenModelToJson(OrdenModel data) => json.encode(data.toJson());

class OrdenModel {
    final List<OCompra> oCompra;

    OrdenModel({
        required this.oCompra,
    });

    factory OrdenModel.fromJson(Map<String, dynamic> json) => OrdenModel(
        oCompra: List<OCompra>.from(json["OCompra"].map((x) => OCompra.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OCompra": List<dynamic>.from(oCompra.map((x) => x.toJson())),
    };
}

class OCompra {
    final String domain;
    final String orden;
    final String codProv;
    final String nombre;
    final String estatus;

    OCompra({
        required this.domain,
        required this.orden,
        required this.codProv,
        required this.nombre,
        required this.estatus,
    });

    factory OCompra.fromJson(Map<String, dynamic> json) => OCompra(
        domain: json["Domain"],
        orden: json["Orden"],
        codProv: json["CodProv"],
        nombre: json["Nombre"],
        estatus: json["Estatus"],
    );

    Map<String, dynamic> toJson() => {
        "Domain": domain,
        "Orden": orden,
        "CodProv": codProv,
        "Nombre": nombre,
        "Estatus": estatus,
    };
}
