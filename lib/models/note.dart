import 'package:flutter/material.dart';

class Note {
  final int id;
  final String title;
  final String description;
  final DateTime? date;
  final int image;

  Note({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.date,
    this.image = 0,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    int? image,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      image: json['image'] is int ? json['image'] : int.tryParse(json['image']) ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date?.toIso8601String(),
      'image': image,
    };
  }
}
