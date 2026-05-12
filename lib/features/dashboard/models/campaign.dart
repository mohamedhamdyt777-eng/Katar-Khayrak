import 'package:flutter/material.dart';

class Campaign {
  final String id;
  final String title;
  final String date;
  final Color imageColor;
  final String description;
  final String location;
  final double? targetAmount;
  final String? coverImagePath;
  final List<String> galleryImagePaths;
  final int categoryIndex;

  const Campaign({
    required this.id,
    required this.title,
    required this.date,
    required this.imageColor,
    this.description = '',
    this.location = '',
    this.targetAmount,
    this.coverImagePath,
    this.galleryImagePaths = const [],
    this.categoryIndex = 0,
  });
}
