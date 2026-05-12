import 'package:flutter/material.dart';

class FavoriteItem {
  final String title;
  final String date;
  final Color imageColor;

  FavoriteItem({
    required this.title,
    required this.date,
    required this.imageColor,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'imageColor': imageColor.toARGB32(),
    };
  }

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      title: json['title'] as String,
      date: json['date'] as String,
      imageColor: Color(json['imageColor'] as int),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          date == other.date &&
          imageColor.toARGB32() == other.imageColor.toARGB32();

  @override
  int get hashCode => title.hashCode ^ date.hashCode ^ imageColor.toARGB32().hashCode;
}
