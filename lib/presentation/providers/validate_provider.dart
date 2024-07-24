import 'package:flutter_riverpod/flutter_riverpod.dart';

//Validaciones Transferencia Inventario
final validateLocProvider = StateProvider<bool>((ref) {
  return false;
});

final validatePartProvider = StateProvider<bool>((ref) {
  return false;
});

final validateSiteProvider = StateProvider<bool>((ref) {
  return false;
});

final transfProvider = StateProvider<String>((ref) {
  return '';
});

final validateCantidadTransfProvider = StateProvider<bool>((ref) {
  return false;
});

//Validaciones Recepción OC
final validateOrdenProvider = StateProvider<bool>((ref) {
  return false;
});

final ordenProvider = StateProvider<String>((ref) {
  return '';
});

final documentoProvider = StateProvider<String>((ref) {
  return '';
});

final validateDetOCProvider = StateProvider<bool>((ref) {
  return false;
});

final validateCantidadRecepcionProvider = StateProvider<bool>((ref) {
  return false;
});

//Validaciones Ajuste Inventario
final validateArtAjusteInvProvider = StateProvider<bool>((ref) {
  return false;
});

final validateLocAjusteInvProvider = StateProvider<bool>((ref) {
  return false;
});

final validateCantidadAjusteInvProvider = StateProvider<bool>((ref) {
  return false;
});

//Validaciones Entrada Salida
final selectedValueProvider = StateProvider<String>((ref) {
  return 'Entrada';
});

final validateCantidadEntradaSalidaProvider = StateProvider<bool>((ref) {
  return false;
});
