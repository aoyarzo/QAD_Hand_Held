import 'package:flutter/material.dart';

InputDecoration inputDecorationTextFormField() {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black38, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    fillColor: Colors.grey[300],
    //labelText: 'Almacen',
    labelStyle: const TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black38, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}