import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';


class Utility {
  static Image ImageFromBase64String(String base64String){
    //return Image.memory(base64Decode(base64String));
    return Image.memory(
      const Base64Decoder().convert(base64String),
      fit: BoxFit.fill,
    );
  }

  // Uint: Entero sin signo de 8 bits
  static Uint8List dataFromBase64String(String base64String){
    return const Base64Decoder().convert(base64String);
  }

  static String base64String(Uint8List data){
    return base64Encode(data);
  }
}