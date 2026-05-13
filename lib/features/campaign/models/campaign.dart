import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Campaign {
  final String id;
  final String title;
  final String date;
  final Color imageColor;
  final String description;
  final String location;
  final double? targetAmount;
  final double raisedAmount;
  final String? coverImagePath;
  final List<String> galleryImagePaths;
  final int categoryIndex;
  final String? organizationId;

  const Campaign({
    required this.id,
    required this.title,
    required this.date,
    required this.imageColor,
    this.description = '',
    this.location = '',
    this.targetAmount,
    this.raisedAmount = 0,
    this.coverImagePath,
    this.galleryImagePaths = const [],
    this.categoryIndex = 0,
    this.organizationId,
  });

  /// Creates a Campaign from a Firestore document.
  factory Campaign.fromFirestore(String id, Map<String, dynamic> data) {
    return Campaign(
      id: id,
      title: data['title'] as String? ?? '',
      date: data['date'] as String? ?? '',
      imageColor: Color(data['imageColorValue'] as int? ?? Colors.teal.shade100.toARGB32()),
      description: data['description'] as String? ?? '',
      location: data['location'] as String? ?? '',
      targetAmount: (data['targetAmount'] as num?)?.toDouble(),
      raisedAmount: (data['raisedAmount'] as num?)?.toDouble() ?? 0,
      coverImagePath: data['coverImagePath'] as String?,
      galleryImagePaths: List<String>.from(data['galleryImagePaths'] as List? ?? []),
      categoryIndex: data['categoryIndex'] as int? ?? 0,
      organizationId: data['organizationId'] as String?,
    );
  }

  /// Converts the Campaign to a base Firestore map (no createdAt).
  /// Use [toFirestoreCreate] for new documents.
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': date,
      'imageColorValue': imageColor.toARGB32(),
      'description': description,
      'location': location,
      'targetAmount': targetAmount,
      'raisedAmount': raisedAmount,
      'coverImagePath': coverImagePath,
      'galleryImagePaths': galleryImagePaths,
      'categoryIndex': categoryIndex,
      'organizationId': organizationId,
    };
  }

  /// Use this when first creating a document — adds server timestamp.
  Map<String, dynamic> toFirestoreCreate() {
    return {
      ...toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  Campaign copyWith({
    String? id,
    String? title,
    String? date,
    Color? imageColor,
    String? description,
    String? location,
    double? targetAmount,
    double? raisedAmount,
    String? coverImagePath,
    List<String>? galleryImagePaths,
    int? categoryIndex,
    String? organizationId,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      imageColor: imageColor ?? this.imageColor,
      description: description ?? this.description,
      location: location ?? this.location,
      targetAmount: targetAmount ?? this.targetAmount,
      raisedAmount: raisedAmount ?? this.raisedAmount,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      galleryImagePaths: galleryImagePaths ?? this.galleryImagePaths,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
