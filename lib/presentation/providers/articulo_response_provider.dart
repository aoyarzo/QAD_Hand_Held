
import 'package:flutter_riverpod/flutter_riverpod.dart';

final descripcionProvider = StateProvider<String>((ref) {
  return '';
});

final cantAbiertaProvider = StateProvider<double>((ref) {
  return 0;
});

final precioProvider = StateProvider<double>((ref) {
  return 0;
});