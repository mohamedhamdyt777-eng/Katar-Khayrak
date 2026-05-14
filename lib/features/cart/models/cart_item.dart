import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final Color imageColor;

  CartItem({
    required this.title,
    required this.imageColor,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageColor': imageColor.toARGB32(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      title: json['title'] as String,
      imageColor: Color(json['imageColor'] as int),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          imageColor.toARGB32() == other.imageColor.toARGB32();

  @override
  int get hashCode => title.hashCode ^ imageColor.toARGB32().hashCode;
}
