import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final validateOrdenProvider = StateProvider<bool>((ref) {
  return false;
});

final validateDetOCProvider = StateProvider<bool>((ref) {
  return false;
});
