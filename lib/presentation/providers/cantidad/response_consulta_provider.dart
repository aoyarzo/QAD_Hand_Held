import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/models.dart';


final responseConsultaChangeNotifierProvider =
    ChangeNotifierProvider<ResponseConsultaChangeNotifier>((ref) {
  return ResponseConsultaChangeNotifier();
});

class ResponseConsultaChangeNotifier extends ChangeNotifier {
  List<Consulta> consulta = [];

  void addConsulta(String dominio, String articulo, String almacen, 
  String ubicacion, String loteSerie, String referencia, double cantInv, 
  double cantAsig, double cantDisp) {
    consulta = [
      ...consulta,
      Consulta(
        dominio: dominio, 
        articulo: articulo, 
        almacen: almacen, 
        ubicacion: ubicacion, 
        loteSerie: loteSerie, 
        referencia: referencia, 
        cantInv: cantInv, 
        cantAsig: cantAsig, 
        cantDisp: cantDisp)
    ];
    notifyListeners();
  }

  void clearConsulta() {
    consulta.clear();
    notifyListeners();
  }
}