import 'dart:convert';

ConsultaModel consultaModelFromJson(String str) => ConsultaModel.fromJson(json.decode(str));

String consultaModelToJson(ConsultaModel data) => json.encode(data.toJson());

class ConsultaModel {
    final List<Consulta> consulta;

    ConsultaModel({
        required this.consulta,
    });

    factory ConsultaModel.fromJson(Map<String, dynamic> json) => ConsultaModel(
        consulta: List<Consulta>.from(json["Consulta"].map((x) => Consulta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Consulta": List<dynamic>.from(consulta.map((x) => x.toJson())),
    };
}

class Consulta {
    final String dominio;
    final String articulo;
    final String almacen;
    final String ubicacion;
    final String loteSerie;
    final String referencia;
    final double cantInv;
    final double cantAsig;
    final double cantDisp;

    Consulta({
        required this.dominio,
        required this.articulo,
        required this.almacen,
        required this.ubicacion,
        required this.loteSerie,
        required this.referencia,
        required this.cantInv,
        required this.cantAsig,
        required this.cantDisp,
    });

    factory Consulta.fromJson(Map<String, dynamic> json) => Consulta(
        dominio: json["Dominio"],
        articulo: json["Articulo"],
        almacen: json["Almacen"],
        ubicacion: json["Ubicacion"],
        loteSerie: json["LoteSerie"],
        referencia: json["Referencia"],
        cantInv: json["CantInv"]?.toDouble(),
        cantAsig: json["CantAsig"]?.toDouble(),
        cantDisp: json["CantDisp"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Dominio": dominio,
        "Articulo": articulo,
        "Almacen": almacen,
        "Ubicacion": ubicacion,
        "LoteSerie": loteSerie,
        "Referencia": referencia,
        "CantInv": cantInv,
        "CantAsig": cantAsig,
        "CantDisp": cantDisp,
    };
}
