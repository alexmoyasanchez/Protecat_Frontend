import 'package:flutter/material.dart';

class Colony{
  final String id;
  final String name;
  final String locationx;
  final String locationy;
  final String observations;
  final List<dynamic> cats;

  Colony({
    @required this.id,
    @required this.name,
    @required this.locationx,
    @required this.locationy,
    @required this.observations,
    @required this.cats
  } 
  );

  factory Colony.fromJson(Map<String, dynamic> json) {
    return Colony(
      id: json['id'],
      name: json['name'],      
      locationx: json['locationx'],
      locationy: json['locationy'],
      observations: json['observations'],
      cats: json['cats']
    );
  }

}