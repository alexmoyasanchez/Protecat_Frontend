import 'package:flutter/material.dart';

class Cat{
  final String id;
  final String name;
  final String sex;
  final String weight;
  final String compatibilities;
  final String incompatibilities;
  final String diseases;
  final String imageUrl;
  final Map<String, dynamic> colony;

  Cat({
    @required this.id,
    @required this.name,
    @required this.sex,
    @required this.weight,
    @required this.compatibilities,
    @required this.incompatibilities,
    @required this.diseases,
    @required this.imageUrl,
    @required this.colony
  } 
  );

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      name: json['name'],      
      sex: json['sex'],
      weight: json['weight'],
      compatibilities: json['compatibilities'],
      incompatibilities: json['incompatibilities'],
      diseases: json['diseases'],
      imageUrl: json['imageUrl'],
      colony: json['colony']
    );
  }

}