import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  String? id;
  String? uid;
  String? title;
  String? titleLower; // Stored for case-insensitive search
  String? descritpion;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  String? category;
  List<String> likes = [];
  Event({
    required this.id,
    required this.uid,
    required this.title,
    this.titleLower,
    required this.descritpion,
    required this.dateTime,
    required this.timeOfDay,
    required this.category,
    this.likes = const [],
  });

  Map<String, dynamic> toFirestore() {
    int time = DateTime(
      dateTime!.year,
      dateTime!.month,
      dateTime!.day,
      timeOfDay!.hour,
      timeOfDay!.minute,
    ).millisecondsSinceEpoch;

    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'titleLower': (title ?? '').toLowerCase(),
      'descritpion': descritpion,
      'dateTime': time,
      'category': category,
      'likes': likes,
    };
  }

  factory Event.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? s,
  ) {
    final document = snapshot.data();
    int dateTime = document?['dateTime'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);
    TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
    final likesData = document?['likes'] as List<dynamic>? ?? [];
    return Event(
      id: document?["id"],
      uid: document?["uid"],
      title: document?["title"],
      titleLower: document?["titleLower"],
      descritpion: document?['descritpion'],
      dateTime: date,
      timeOfDay: time,
      category: document?['category'],
      likes: likesData.map((e) => e.toString()).toList(),
    );
  }
}
