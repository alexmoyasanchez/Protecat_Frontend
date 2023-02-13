import 'package:flutter/material.dart';

class Task{
  final String id;
  final String date;
  final String subject;
  final String description;
  final bool done;
  final List<dynamic> volunteer;

  Task({
    @required this.id,
    this.date,
    @ required this.subject,
    this.description,
    this.done,
    this.volunteer
  } 
  );

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      date: json['date'],      
      subject: json['subject'],
      description: json['description'],
      done: json['done'],
      volunteer: json['volunteer']
    );
  }

}