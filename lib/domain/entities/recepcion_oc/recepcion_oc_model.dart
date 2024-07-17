import 'dart:convert';

RecepcionOcModel recepcionOcModelFromJson(String str) =>
    RecepcionOcModel.fromJson(json.decode(str));

String recepcionOcModelToJson(RecepcionOcModel data) =>
    json.encode(data.toJson());

class RecepcionOcModel {
  final int idRecepcion;
  final String dominio;
  final String orden;
  final String proveedor;
  final String efectiva;
  final String funda;
  final String articulo;
  final int linea;
  final double costo;
  final double cantidad;
  final String almacen;
  final String ubicacion;
  final String lote;
  final String referencia;
  final String fchVcto;
  final String usuario;

  RecepcionOcModel({
    required this.idRecepcion,
    required this.dominio,
    required this.orden,
    required this.proveedor,
    required this.efectiva,
    required this.funda,
    required this.articulo,
    required this.linea,
    required this.costo,
    required this.cantidad,
    required this.almacen,
    required this.ubicacion,
    required this.lote,
    required this.referencia,
    required this.fchVcto,
    required this.usuario,
  });

  factory RecepcionOcModel.fromJson(Map<String, dynamic> json) =>
      RecepcionOcModel(
        idRecepcion: json["IdRecepcion"],
        dominio: json["Dominio"],
        orden: json["Orden"],
        proveedor: json["Proveedor"],
        efectiva: json["Efectiva"],
        funda: json["Funda"],
        articulo: json["Articulo"],
        linea: json["Linea"],
        costo: json["Costo"]?.toDouble(),
        cantidad: json["Cantidad"]?.toDouble(),
        almacen: json["Almacen"],
        ubicacion: json["Ubicacion"],
        lote: json["Lote"],
        referencia: json["Referencia"],
        fchVcto: json["FchVcto"],
        usuario: json["Usuario"],
      );

  Map<String, dynamic> toJson() => {
        "IdRecepcion": idRecepcion,
        "Dominio": dominio,
        "Orden": orden,
        "Proveedor": proveedor,
        "Efectiva": efectiva,
        "Funda": funda,
        "Articulo": articulo,
        "Linea": linea,
        "Costo": costo,
        "Cantidad": cantidad,
        "Almacen": almacen,
        "Ubicacion": ubicacion,
        "Lote": lote,
        "Referencia": referencia,
        "FchVcto": fchVcto,
        "Usuario": usuario,
      };
}
