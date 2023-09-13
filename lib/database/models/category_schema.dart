import 'package:flutter/services.dart';

class Category {
  final String name;
  final Uint8List imageBytes;

  Category({
    required this.name,
    required this.imageBytes,
  });
}
